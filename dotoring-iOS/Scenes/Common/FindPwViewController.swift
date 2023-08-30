//
//  FindPwViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/30.
//

import UIKit

class FindPwViewController: UIViewController {
    
    var findPwView: FindPwView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setNavigationItems()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func loadView() {
        super.loadView()
        
        findPwView = FindPwView(frame: self.view.frame)
        
        findPwView.goLoginButtonActionHandler = { [weak self] in
            self?.handleGoLoginButtonTapped()
        }
        
        self.view = findPwView
    }
    
    private func setNavigationItems() {
        navigationItem.title = "비밀번호 찾기"
        navigationController?.navigationBar.topItem?.backButtonTitle = "로그인"
        navigationController?.navigationBar.tintColor = .label
        
    }
    
    func handleGoLoginButtonTapped() {
        if let viewControllers = self.navigationController?.viewControllers, viewControllers.count >= 2 {
            let destinationVC = viewControllers[viewControllers.count - 2]
            self.navigationController?.popToViewController(destinationVC, animated: true)
        }
    }

}
