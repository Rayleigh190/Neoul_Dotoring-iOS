//
//  BusinessDetailViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/8/24.
//

import UIKit

class BusinessDetailViewController: UIViewController {
    
    var businessDetailView = BusinessDetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
    }
    
    override func loadView() {
        super.loadView()
        businessDetailView = BusinessDetailView(frame: self.view.frame)
        self.view = businessDetailView
    }
}

private extension BusinessDetailViewController {
    func setupNavigationController() {
        navigationItem.title = "지원사업명"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .BaseGray900
    }
}
