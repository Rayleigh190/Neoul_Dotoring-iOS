//
//  FindIdCheckViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/29.
//

import UIKit

class FindIdCheckViewController: UIViewController {
    
    var findIdCheckView: FindIdCheckView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setNavigationItems()
    }
    
    override func loadView() {
        super.loadView()
        
        findIdCheckView = FindIdCheckView(frame: self.view.frame)
        
        findIdCheckView.goLoginButtonActionHandler = { [weak self] in
            self?.handleGoLoginButtonTapped()
        }
        
        self.view = findIdCheckView
    }
    
    private func setNavigationItems() {
        navigationItem.title = "아이디 찾기"
        navigationItem.hidesBackButton = true
        
    }
    
    func handleGoLoginButtonTapped() {
        if let viewControllers = self.navigationController?.viewControllers, viewControllers.count >= 3 {
            let destinationVC = viewControllers[viewControllers.count - 3]
            self.navigationController?.popToViewController(destinationVC, animated: true)
        }
    }

}

extension FindIdCheckViewController {
    
    
}
