//
//  ReportReasonAlertViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/14.
//

import UIKit

class ReportReasonAlertViewController: UIViewController {
    
    var reportReasonAlertView: ReportReasonAlertView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        super.loadView()
        
        reportReasonAlertView = ReportReasonAlertView(frame: self.view.frame)
        setButtonAddTarget()
        
        self.view = reportReasonAlertView
    }

}

private extension ReportReasonAlertViewController {
    
    func setButtonAddTarget() {
        reportReasonAlertView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        reportReasonAlertView.confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    @objc func cancelButtonTapped(sender: UIButton!) {
        self.dismiss(animated: true)
        return
    }
    
    @objc func confirmButtonTapped(sender: UIButton!) {
        
//        let preVC = self.presentingViewController
//        print(self.present)
//        guard let vc = preVC as? UserDetailViewController else {
//            print("여기1")
//            return
//        }
//        vc.isReportConfirmButtonClicked = true
//
//        self.presentingViewController?.dismiss(animated: true)
        self.dismiss(animated: true)
        
    }
}
