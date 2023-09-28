//
//  MentoSignup6ViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/24.
//

import UIKit

class Signup6ViewController: UIViewController {

    var signup6View: Signup6View!
    var fCurTextfieldBottom: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.hideKeyboardWhenTappedAround()
        navigationController?.navigationBar.topItem?.title = ""
        setDelegate()
        registerForKeyboardNotifications()
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    override func loadView() {
        super.loadView()
        
        signup6View = Signup6View(frame: self.view.frame)
        
        signup6View.loginButtonActionHandler = { [weak self] in
            self?.loginButtonTapped()
        }
        
        self.view = signup6View
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.setAnimationsEnabled(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.setAnimationsEnabled(false)
    }
    
    func setDelegate() {
        signup6View.idTextField.textField.delegate = self
        signup6View.pwTextField.textField.delegate = self
        signup6View.rePwTextField.textField.delegate = self
        signup6View.emailTextField.textField.delegate = self
        signup6View.authCodeTextField.textField.delegate = self
    }
    
    func loginButtonTapped() {
        if let viewControllers = self.navigationController?.viewControllers, viewControllers.count >= 8 {
            let destinationVC = viewControllers[viewControllers.count - 8]
            self.navigationController?.popToViewController(destinationVC, animated: true)
        }
    }

}

extension Signup6ViewController: UITextFieldDelegate {
    
    // 텍스트필드에서 리턴키 눌르면 다음 텍스트필드로 포커싱 맞춰짐
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == signup6View.idTextField.textField {
            signup6View.pwTextField.textField.becomeFirstResponder()
        } else if textField == signup6View.pwTextField.textField {
            signup6View.rePwTextField.textField.becomeFirstResponder()
        } else if textField == signup6View.rePwTextField.textField {
            signup6View.emailTextField.textField.becomeFirstResponder()
        } else if textField == signup6View.emailTextField.textField{
            signup6View.authCodeTextField.textField.becomeFirstResponder()
        } else {
            signup6View.authCodeTextField.textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let textFieldFrame = textField.convert(textField.bounds, to: self.view)
        fCurTextfieldBottom = textFieldFrame.origin.y + textFieldFrame.size.height
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if fCurTextfieldBottom <= self.view.frame.height - keyboardSize.height {
                return
            }
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
}
