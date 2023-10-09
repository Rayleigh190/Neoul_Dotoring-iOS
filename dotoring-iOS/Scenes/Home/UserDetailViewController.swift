//
//  UserDetailViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/07.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var userDetailView: UserDetailView!
    
    private var rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: UserDetailViewController.self, action: .none)
        
        return barButtonItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
        
        
        for i in 1...6 {
            let fieldRectView = FieldRectView()
            fieldRectView.contentLabel.text = "분야 \(i)"
            userDetailView.fieldStackView.addArrangedSubview(fieldRectView)
        }
        
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
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
}
