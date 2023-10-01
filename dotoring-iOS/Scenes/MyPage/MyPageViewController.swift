//
//  MyPageViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/30.
//

import UIKit

class MyPageViewController: UIViewController {
    
    var myPageView: MyPageView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        super.loadView()
        
        myPageView = MyPageView(frame: self.view.frame)
        
        myPageView.setMentoringButtonActionHandler = { [weak self] in
            self?.handleSetMentoringButtonTapped()
        }
        myPageView.setAccountButtonActionHandler = { [weak self] in
            self?.handleSetAccountButtonTapped()
        }
        
        self.view = myPageView
    }

}

extension MyPageViewController {
    
    func handleSetMentoringButtonTapped() {
        let vc = MentoringSetViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleSetAccountButtonTapped() {
        let vc = AccountSetViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
