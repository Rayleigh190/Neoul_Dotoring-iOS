//
//  LoginViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/26.
//

import SnapKit
import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    var loginView: LoginView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        self.hideKeyboardWhenTappedAround()
        self.setKeyboardObserver()
        setDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.setAnimationsEnabled(true)
    }
    
    override func loadView() {
        super.loadView()
        
        loginView = LoginView(frame: self.view.frame)
        
        // Set the login button action handler
        loginView.loginButtonActionHandler = { [weak self] in
            self?.handleLoginButtonTapped()
        }
        loginView.findIdButtonActionHandler = { [weak self] in
            self?.handleFindIdButtonTapped()
        }
        loginView.findPwButtonActionHandler = { [weak self] in
            self?.handleFindPwButtonTapped()
        }
        loginView.signupButtonActionHandler = { [weak self] in
            self?.handleSignupButtonTapped()
        }
        
        self.view = loginView
    }
    
}

extension LoginViewController {
    
    func setDelegate() {
        loginView.idTextField.textField.delegate = self
        loginView.pwTextField.textField.delegate = self
    }
    
    // MARK: - Button action methods
    // 로그인 버튼이 클릭 되었을때
    func handleLoginButtonTapped() {
        print("LoginViewController  - handleLoginButtonTapped() called")
        
        guard let userInputID = self.loginView.idTextField.textField.text else { return }
        guard let userInputPW = self.loginView.pwTextField.textField.text else { return }
        
        // 사용자가 입력한 아이디와 비밀번호를 받습니다.
        let urlToCall = BaseRouter.userLogin(userID: userInputID, userPW: userInputPW)
        
        BaseNetworkManager
            .shared
            .session
            .request(urlToCall)
            .validate(statusCode: 200...400) // 200~400 사이가 아니면 interceptor에서 retry를 함
            .responseDecodable(of: LoginAPIResponse.self) { response in
                switch response.result {
                case .success(let successData):
                    print("LoginViewController - handleLoginButtonTapped() : 로그인 성공")
                    debugPrint(successData)
                    if successData.success == true {
                        // 토큰 저장
                        guard let accessToken = response.response?.value(forHTTPHeaderField: "Authorization") else { return }
                        print("인증 토큰 : \(accessToken)")
                        
                        // 홈 화면으로 이동
                        let vc = MainTapBarController()
                        vc.modalTransitionStyle = .crossDissolve
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    }
                case .failure(let error):
                    print("LoginViewController - handleLoginButtonTapped() : 로그인 실패")
                    debugPrint(error)
                    self.loginView.warningLabel.isHidden = false
                }
                
                debugPrint(response)
            }

    }
    
    func handleFindIdButtonTapped() {
        let vc = FindIdViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleFindPwButtonTapped() {
        let vc = FindPwViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleSignupButtonTapped() {
        let vc = IntroViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    // 텍스트필드에서 리턴키 눌르면 다음 텍스트필드로 포커싱 맞춰짐
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginView.idTextField.textField {
            loginView.pwTextField.textField.becomeFirstResponder()
        } else {
            loginView.pwTextField.textField.resignFirstResponder()
        }
        return true
    }
    
}
