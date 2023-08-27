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
        self.hideKeyboardWhenTappedAround()
        self.setKeyboardObserver()
    }
    
    override func loadView() {
        super.loadView()
        
        loginView = LoginView(frame: self.view.frame)
        self.view = loginView
    }
    
}
