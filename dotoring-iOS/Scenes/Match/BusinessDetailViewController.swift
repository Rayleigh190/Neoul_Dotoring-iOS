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
        setAddTarget()
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
    
    func setAddTarget() {
        businessDetailView.joinButton.addTarget(self, action: #selector(joinButtonTapped), for: .touchUpInside)
    }
    
    @objc func joinButtonTapped(sender: UIButton) {
        let vc = BusinessDetailAlertViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}
