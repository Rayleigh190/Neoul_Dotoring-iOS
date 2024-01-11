//
//  BusinessEditViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/8/24.
//

import UIKit

class BusinessEditViewController: UIViewController {
    var businessEditView: BusinessEditView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
    }
    
    override func loadView() {
        super.loadView()
        
        businessEditView = BusinessEditView(frame: self.view.frame)
        self.view = businessEditView
    }

}

private extension BusinessEditViewController {
    func setupNavigationController() {
        navigationItem.title = "모집글 작성"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .BaseGray900
    }
}
