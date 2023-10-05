//
//  AccountConfirmViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/05.
//

import UIKit

class AccountConfirmViewController: UIViewController {

    var accountConfirmView: AccountConfirmView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.setKeyboardObserver()
        setDelegate()
    }
    
    override func loadView() {
        super.loadView()
        
        accountConfirmView = AccountConfirmView(frame: self.view.frame)
        
//        setButtonAddTarget()

        self.view = accountConfirmView
    }
    
    func setDelegate() {
        accountConfirmView.idTextField.textField.delegate = self
        accountConfirmView.pwTextField.textField.delegate = self
    }
    

}

extension AccountConfirmViewController: UITextFieldDelegate {
    
    // 텍스트필드에서 리턴키 눌르면 다음 텍스트필드로 포커싱 맞춰짐
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == accountConfirmView.idTextField.textField {
            accountConfirmView.pwTextField.textField.becomeFirstResponder()
        } else {
            accountConfirmView.pwTextField.textField.resignFirstResponder()
        }
        return true
    }
    
}
