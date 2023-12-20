//
//  FindIdView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/29.
//

import UIKit

class FindIdView: UIView {
    
    // 뷰 전체 높이 길이
    let screenHeight = UIScreen.main.bounds.size.height
    
    var authButtonActionHandler: (() -> Void)?
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .L, size: 28)
        label.textColor = .label
        let text = "회원가입에서 사용한\n이메일을 입력해 주세요."
        label.text = text
        label.numberOfLines = 2
        
        let fontSize = UIFont.nanumSquare(style: .NanumSquareOTFB, size: 25)
        let attributedStr = NSMutableAttributedString(string: text)

        attributedStr.addAttribute(.font, value: fontSize, range: (text as NSString).range(of: "이메일"))
        label.attributedText = attributedStr
        
        
        return label
    }()
    
    private lazy var emailTextField: LineTextField = {
        let textField = LineTextField()
        textField.isButtonVisible = true
        textField.textField.placeholder = "이메일"
        textField.button.setTitle("인증 코드 발송", for: .normal)
        return textField
    }()
    
    private lazy var authCodeTextField: LineTextField = {
        let textField = LineTextField()
        textField.isButtonVisible = true
        textField.textField.placeholder = "인증 코드"
        textField.button.setTitle("인증하기", for: .normal)
        textField.button.addTarget(self, action: #selector(authButtonTapped), for: .touchUpInside)
        return textField
    }()
    
    private lazy var emailWarningLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "등록되지 않은 이메일이에요."
        label.textColor = .BaseWarningRed
        
        return label
    }()
    
    private lazy var authWarningLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "인증 코드가 달라요."
        label.textColor = .BaseWarningRed
        
        return label
    }()
    
    private lazy var authTimerLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "05:00"
        label.textColor = .BaseWarningRed
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        setupSubViews()
    }


}

private extension FindIdView {
    
    func setupSubViews() {
        
        [titleLabel, emailTextField, authCodeTextField, emailWarningLabel, authWarningLabel, authTimerLabel].forEach { addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            if screenHeight <= 568 {
                $0.top.equalToSuperview().inset(100)
            } else if screenHeight <= 667 && 568 < screenHeight {
                $0.top.equalToSuperview().inset(150)
            }
            else {
                $0.top.equalToSuperview().inset(208.0)
            }
        }
        
        emailTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(110)
        }
        
        authCodeTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(emailTextField.snp.bottom).offset(42.0)
        }
        
        emailWarningLabel.snp.makeConstraints {
            $0.leading.equalTo(emailTextField.snp.leading)
            $0.top.equalTo(emailTextField.snp.bottom).offset(12.0)
        }
        
        authWarningLabel.snp.makeConstraints {
            $0.leading.equalTo(authCodeTextField.snp.leading)
            $0.top.equalTo(authCodeTextField.snp.bottom).offset(12.0)
        }
        
        authTimerLabel.snp.makeConstraints {
            $0.centerX.equalTo(authCodeTextField.button)
            $0.bottom.equalTo(authCodeTextField.button.snp.top).offset(-5.0)
        }
    }
}

extension FindIdView {
    
    @objc func authButtonTapped(sender: UIButton!) {
        // Call the closure when the login button is tapped
        authButtonActionHandler?()
    }
    
}
