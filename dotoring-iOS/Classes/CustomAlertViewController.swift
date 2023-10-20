//
//  CustomAlertViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/01.
//

import UIKit

// Custom Alert의 버튼의 액션을 처리하는 Delegate
protocol CustomAlertDelegate {
    func action()   // confirm button event
    func exit()     // cancel button event
}

enum AlertType {
    case onlyConfirm    // 확인 버튼
    case canCancel      // 확인 + 취소 버튼
}

enum AlertContentFontSize {
    case small
    case large
}


class CustomAlertViewController: UIViewController {
    
    var customAlertView: CustomAlertView!
    var delegate: CustomAlertDelegate?
    
    var alertType: AlertType = .onlyConfirm
    var alertText = ""
    var highlightText = ""
    var boldText = ""
    var contentFontSieze: AlertContentFontSize = .small
    var hasSecondaryText: Bool = false
    var secondaryText = ""
    var cancelButtonText = ""
    var confirmButtonText = ""
    var changeButtonPosition: Bool = false
    var cancelButtonHighlight: Bool = false
    var confirmButtonHighlight: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        super.loadView()
        
        customAlertView = CustomAlertView(hasSecondaryText: hasSecondaryText, changeButtonPosition: changeButtonPosition)
        customAlertView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        customAlertView.confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        
        // 컨텐츠 텍스트 설정
        customAlertView.contentLabel.text = alertText
        let attributedStr = NSMutableAttributedString(string: alertText)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.BaseWarningRed!, range: (alertText as NSString).range(of: highlightText))
        attributedStr.addAttribute(.font, value: UIFont.nanumSquare(style: .NanumSquareOTFEB, size: 17), range: (alertText as NSString).range(of: boldText))
        
        customAlertView.contentLabel.attributedText = attributedStr
        
        // 취소, 확인 버튼 타이틀 설정
        customAlertView.cancelButton.setTitle(cancelButtonText, for: .normal)
        customAlertView.confirmButton.setTitle(confirmButtonText, for: .normal)
        
        // 알림 타입별 화면 설정
        if alertType == .onlyConfirm {
            customAlertView.cancelButton.isHidden = true
        } else {
            
        }
        
        // 컨텐츠 글 폰트 사이즈 설정
        if contentFontSieze == .large {
            customAlertView.contentLabel.font = .nanumSquare(style: .NanumSquareOTFR, size: 20)
        }
        
        // 보조 텍스트 숨기기, 아니면 보조 텍스트 설정
        if hasSecondaryText == false {
            customAlertView.secondaryLabel.isHidden = true
        } else {
            customAlertView.secondaryLabel.text = secondaryText
        }
        
        // 취소, 확인 버튼 배경 하이라이트 설정
        if cancelButtonHighlight == true {
            customAlertView.cancelButton.backgroundColor = .BaseWarningRed
        }
        if confirmButtonHighlight == true {
            customAlertView.confirmButton.backgroundColor = .BaseWarningRed
        }
        
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
        boldText: String = "",
        contentFontSieze: AlertContentFontSize = .small,
        hasSecondaryText: Bool = false,
        secondaryText: String = "",
        cancelButtonText: String? = "",
        confirmButtonText: String,
        changeButtonPosition: Bool = false,
        cancelButtonHighlight: Bool = false,
        confirmButtonHighlight: Bool = false
    ) {
        
        let customAlertViewController = CustomAlertViewController()

        customAlertViewController.delegate = self
        customAlertViewController.modalPresentationStyle = .overFullScreen
        customAlertViewController.modalTransitionStyle = .crossDissolve
        customAlertViewController.alertText = alertText
        customAlertViewController.contentFontSieze = contentFontSieze
        customAlertViewController.alertType = alertType
        customAlertViewController.cancelButtonText = cancelButtonText ?? ""
        customAlertViewController.confirmButtonText = confirmButtonText
        customAlertViewController.highlightText = highlightText
        customAlertViewController.boldText = boldText
        customAlertViewController.hasSecondaryText = hasSecondaryText
        customAlertViewController.secondaryText = secondaryText
        customAlertViewController.changeButtonPosition = changeButtonPosition
        customAlertViewController.cancelButtonHighlight = cancelButtonHighlight
        customAlertViewController.confirmButtonHighlight = confirmButtonHighlight
        
        self.present(customAlertViewController, animated: true, completion: nil)
    }
}
