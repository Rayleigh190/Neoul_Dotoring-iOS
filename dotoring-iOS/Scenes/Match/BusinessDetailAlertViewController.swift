//
//  BusinessDetailAlertViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/14/24.
//

import UIKit

class BusinessDetailAlertViewController: UIViewController {
    var businessDetailAlertView = BusinessDetailAlertView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
    }
    
    override func loadView() {
        super.loadView()
        businessDetailAlertView = BusinessDetailAlertView(frame: self.view.frame)
        self.view = businessDetailAlertView
    }
}

private extension BusinessDetailAlertViewController {
    func setAddTarget() {
        businessDetailAlertView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    @objc func cancelButtonTapped(sender: UIButton) {
        self.dismiss(animated: true)
    }
}
