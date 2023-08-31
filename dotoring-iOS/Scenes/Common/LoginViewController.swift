//
//  LoginViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/26.
//

import SnapKit
import UIKit

class LoginViewController: UIViewController {
    
    var loginView: LoginView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        self.hideKeyboardWhenTappedAround()
        self.setKeyboardObserver()
    }
    
    override func loadView() {
        super.loadView()
        
        loginView = LoginView(frame: self.view.frame)
        
        // Set the login button action handler
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
