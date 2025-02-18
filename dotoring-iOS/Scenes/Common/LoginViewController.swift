//
//  LoginViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/26.
//

import SnapKit
import UIKit
import Alamofire
import Toast

class LoginViewController: UIViewController {
    
    var loginView: LoginView!
    var isAutoLogin = false
    var isFromMyPage = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.title = "로그인"
//        self.hideKeyboardWhenTappedAround()
//        self.setKeyboardObserver()
        setDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAutoLogin()
        UIView.setAnimationsEnabled(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        if isFromMyPage {
            Alert.showAlert(title: "알림", message: "로그아웃 되었습니다. 서류 승인 후 로그인 가능합니다.")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
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
    
    func checkAutoLogin() {
        print("LoginVC - checkAutoLogin() called")
        if let userID = KeyChain.read(key: KeyChainKey.userID),
           let userPW = KeyChain.read(key: KeyChainKey.userPW) {
            isAutoLogin = true
            getLogin(userID: userID, userPW: userPW, setAutoLogin: false)
            print("LoginViewController - checkAutoLogin() : 자동 로그인 성공")
        } else {
            loginView.launchScreenCover.isHidden = true
            isAutoLogin = false
        }
    }
    
    // MARK: - Button action methods
    // 로그인 버튼이 클릭 되었을때
    func handleLoginButtonTapped() {
        print("LoginViewController  - handleLoginButtonTapped() called")
        
        guard let userInputID = self.loginView.idTextField.textField.text else { return }
        guard let userInputPW = self.loginView.pwTextField.textField.text else { return }
        let setAutoLogin = loginView.autoLoginCheckBox.isChecked
        
        if userInputID == "" || userInputPW == "" {
            Alert.showAlert(title: "안내", message: "아이디와 비밀번호를 입력하세요.")
            return
        }
        
        getLogin(userID: userInputID, userPW: userInputPW, setAutoLogin: setAutoLogin)
        
    }
    
    func getLogin(userID: String, userPW: String, setAutoLogin: Bool) {
        if !isAutoLogin {self.view.makeToastActivity(.center)}
        CommonNetworkService.getLogin(userID: userID, userPW: userPW, setAutoLogin: setAutoLogin) { response, error in

            if response?.success == true {
                // 로그인 성공
                // 홈 화면으로 이동
                let vc = MainTapBarController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
                self.view.hideToastActivity()
            } else {
                // 로그인 실패
                self.view.hideToastActivity()
                if error != nil {
                    if !self.isAutoLogin {self.view.hideToastActivity()}
                    // 로그인 요청 에러 발생
                    print("로그인 요청 오류 발생 : \(error?.asAFError?.responseCode ?? 0)")
                    if let statusCode = error?.asAFError?.responseCode {
                        Alert.showAlert(title: "로그인 요청 오류 발생", message: "\(statusCode)")
                    } else {
                        Alert.showAlert(title: "로그인 요청 오류 발생", message: "네트워크 연결을 확인하세요.")
                    }
                } else {
                    switch response?.error?.status {
                    case 400:
                        Alert.showAlert(title: "로그인 실패", message: "존재하지 않는 아이디입니다.")
                        self.loginView.warningLabel.isHidden = false
                    case 403:
    //                        Alert.showAlert(title: "로그인 실패", message: "심사중인 회원입니다.")
                        let vc = StandbyViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                    default:
                        Alert.showAlert(title: "로그인 실패", message: "알 수 없는 오류입니다. code : \(response?.error?.status ?? 0)")
                    }
                }
            }
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
