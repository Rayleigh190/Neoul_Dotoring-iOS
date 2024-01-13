//
//  BusinessDetailViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/8/24.
//

import UIKit

class BusinessDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        setupNavigationController()
    }

}

private extension BusinessDetailViewController {
    func setupNavigationController() {
        navigationItem.title = "지원사업명"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
