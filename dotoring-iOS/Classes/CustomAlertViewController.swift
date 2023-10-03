//
//  CustomAlertViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/01.
//

import UIKit

// Custom Alert의 버튼의 액션을 처리하는 Delegate입니다.
protocol CustomAlertDelegate {
    func action()   // confirm button event
    func exit()     // cancel button event
}

enum AlertType {
    case onlyConfirm    // 확인 버튼
    case canCancel      // 확인 + 취소 버튼
}


class CustomAlertViewController: UIViewController {
    
    var customAlertView: CustomAlertView!
    var delegate: CustomAlertDelegate?
    
    var alertType: AlertType = .onlyConfirm
    var alertText = ""
    var cancelButtonText = ""
    var confirmButtonText = ""
    var highlightText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        super.loadView()
        
        customAlertView = CustomAlertView(frame: self.view.frame)
        customAlertView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        customAlertView.confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        
        customAlertView.contentLabel.text = alertText
        let attributedStr = NSMutableAttributedString(string: alertText)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.BaseWarningRed!, range: (alertText as NSString).range(of: highlightText))
        customAlertView.contentLabel.attributedText = attributedStr
        
        
        customAlertView.cancelButton.setTitle(cancelButtonText, for: .normal)
        customAlertView.confirmButton.setTitle(confirmButtonText, for: .normal)
        
        self.view = customAlertView
    }
    
    // 확인 버튼 이벤트 처리
    @objc func confirmButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.action()
        }
    }
    
    // 취소 버튼 이벤트 처리
    @objc func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.exit()
        }
    }
    
}

extension CustomAlertDelegate where Self: UIViewController {
    func showAlert(
        alertType: AlertType,
        alertText: String,
        highlightText: String = "",
        cancelButtonText: String? = "",
        confirmButtonText: String
    ) {
        
        let customAlertViewController = CustomAlertViewController()

        customAlertViewController.delegate = self
        customAlertViewController.modalPresentationStyle = .overFullScreen
        customAlertViewController.modalTransitionStyle = .crossDissolve
        customAlertViewController.alertText = alertText
        customAlertViewController.alertType = alertType
        customAlertViewController.cancelButtonText = cancelButtonText ?? ""
        customAlertViewController.confirmButtonText = confirmButtonText
        customAlertViewController.highlightText = highlightText
        
        self.present(customAlertViewController, animated: true, completion: nil)
    }
}
