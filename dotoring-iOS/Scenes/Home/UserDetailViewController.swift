//
//  UserDetailViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/07.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var userDetailView: UserDetailView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
    }

    override func loadView() {
        super.loadView()
        
        userDetailView = UserDetailView(frame: self.view.frame)
        
//        setButtonAddTarget()

        self.view = userDetailView
    }
    
    private func setNavigationItems() {
        navigationController?.navigationBar.topItem?.backButtonTitle = "추천 멘티"
        navigationController?.navigationBar.tintColor = .white
        
    }
    
}
