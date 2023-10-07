//
//  PasswordResetViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/06.
//

import UIKit

class PasswordResetViewController: UIViewController {
    
    var passwordResetView: PasswordResetView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setNavigationItems()
        setDelegate()
    }
    
    override func loadView() {
        super.loadView()
        
        passwordResetView = PasswordResetView(frame: self.view.frame)
        
        setButtonAddTarget()

        self.view = passwordResetView
    }
   
    private func setNavigationItems() {
        navigationController?.navigationBar.topItem?.backButtonTitle = "계정 설정"
        navigationController?.navigationBar.tintColor = .label
    }

}

extension PasswordResetViewController {
    
    func setDelegate() {
        passwordResetView.pwTextField.textField.delegate = self
        passwordResetView.rePwTextField.textField.delegate = self
    }
    
    func setButtonAddTarget() {
        passwordResetView.reLoginButton.addTarget(self, action: #selector(reLoginButtonTapped), for: .touchUpInside)
    }
    
    @objc func reLoginButtonTapped() {
        showAlert(alertType: .canCancel, alertText: "이대로\n저장하시겠습니까?", highlightText: "저장", contentFontSieze: .large, cancelButtonText: "아니오", confirmButtonText: "네", confirmButtonHighlight: true)
    }
    
}

extension PasswordResetViewController: CustomAlertDelegate {
    func action() {
        print("비밀번호 변경 요청")
        let vc = UINavigationController(rootViewController: LoginViewController())
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func exit() {
        print("비밀번호 변경 취소")
    }
}

extension PasswordResetViewController: UITextFieldDelegate {
    
    // 텍스트필드에서 리턴키 눌르면 다음 텍스트필드로 포커싱 맞춰짐
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordResetView.pwTextField.textField {
            passwordResetView.rePwTextField.textField.becomeFirstResponder()
        } else {
            passwordResetView.rePwTextField.textField.resignFirstResponder()
        }
        return true
    }
    
}
