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

//    @IBOutlet weak var alertView: UIView!
//    @IBOutlet weak var textLabel: UILabel!
//    @IBOutlet weak var cancelButton: UIButton!
//    @IBOutlet weak var confirmButton: UIButton!
    
    var alertType: AlertType = .onlyConfirm
    var alertText = ""
    var cancelButtonText = ""
    var confirmButtonText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // customAlertView 기본 세팅
//        setCustomAlertView()
        
//        switch alertType {
//
//        // alertType에 따른 디자인 처리
//        case .onlyConfirm:
//            cancelButton.isHidden = true
//
//            confirmButton.isHidden = false
//            confirmButton.setTitle(confirmButtonText, for: .normal)
//            confirmButton.widthAnchor.constraint(equalTo: alertView.widthAnchor, multiplier: 1).isActive = true
//
//        case .canCancel:
//            cancelButton.isHidden = false
//            cancelButton.setTitle(cancelButtonText, for: .normal)
//
//            confirmButton.isHidden = false
//            confirmButton.setTitle(confirmButtonText, for: .normal)
//            confirmButton.layer.maskedCorners = CACornerMask.layerMaxXMaxYCorner
//            confirmButton.widthAnchor.constraint(equalTo: alertView.widthAnchor, multiplier: 0.5).isActive = true
//        }
    }
    
    override func loadView() {
        super.loadView()
        
        customAlertView = CustomAlertView(frame: self.view.frame)
        
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

    
//    private func setCustomAlertView() {
//
//        /// customAlertView 둥글기 적용
//        alertView.layer.cornerRadius = 20
//
//        /// alert 내용 폰트 설정
//        textLabel.text = alertText
//        textLabel.textColor = alertTextColor
//        textLabel.font = UIFont(name: myFont, size: 16)
//
//        /// 취소 버튼 둥글기 적용 및 폰트 설정
//        cancelButton.backgroundColor = cancelButtonColor
//        cancelButton.layer.cornerRadius = 20
//        cancelButton.layer.maskedCorners = CACornerMask.layerMinXMaxYCorner
//        cancelButton.titleLabel?.textColor = alertTextColor
//        cancelButton.titleLabel?.font = UIFont(name: myFont, size: 14)
//
//        /// 확인 버튼 둥글기 적용 및 폰트 설정
//        confirmButton.backgroundColor = confirmButtonColor
//        confirmButton.layer.cornerRadius = 20
//        confirmButton.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
//        confirmButton.titleLabel?.textColor = alertTextColor
//        confirmButton.titleLabel?.font = UIFont(name: myFont, size: 14)
//    }
    
    
}
