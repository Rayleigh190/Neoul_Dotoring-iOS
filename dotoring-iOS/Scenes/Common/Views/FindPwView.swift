//
//  FindPwView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/30.
//

import UIKit

class FindPwView: UIView {
    
    // 뷰 전체 높이 길이
    let screenHeight = UIScreen.main.bounds.size.height
    
    var goLoginButtonActionHandler: (() -> Void)?

    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .L, size: 25)
        label.textColor = .label
        let text = "회원가입에서 사용한\n아이디와 이메일을 입력해 주세요."
        label.text = text
        label.numberOfLines = 0
        
        let fontSize = UIFont.nanumSquare(style: .NanumSquareOTFB, size: 25)
        let attributedStr = NSMutableAttributedString(string: text)

        attributedStr.addAttribute(.font, value: fontSize, range: (text as NSString).range(of: "아이디"))
        attributedStr.addAttribute(.font, value: fontSize, range: (text as NSString).range(of: "이메일"))
        label.attributedText = attributedStr
        
        
        return label
    }()
    
    private lazy var subTitleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.textColor = .BaseGray700
        let text = "메일로 새로운 비밀번호를 발송해 드릴게요."
        label.text = text
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var idTextField: LineTextField = {
        let textField = LineTextField()
        textField.textField.placeholder = "아이디"
        return textField
    }()
    
    private lazy var emailTextField: LineTextField = {
        let textField = LineTextField()
        textField.isButtonVisible = true
        textField.textField.placeholder = "이메일"
        textField.button.setTitle("비밀번호 발송", for: .normal)
        return textField
    }()
    
    private lazy var idWarningLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "등록되지 않은 아이디예요."
        label.textColor = .BaseWarningRed
        
        return label
    }()
    
    private lazy var emailWarningLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "등록되지 않은 이메일이에요."
        label.textColor = .BaseWarningRed
        
        return label
    }()
    
    private lazy var authTimerLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "05:00"
        label.textColor = .BaseWarningRed
        
        return label
    }()
    
    private lazy var goLoginButton: BaseButton = {
        let button = BaseButton(style: .black)
        button.setTitle("로그인하러 가기", for: .normal)
        button.addTarget(self, action: #selector(goLoginButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var sendCheckLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "발송 완료되었습니다."
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

private extension FindPwView {
    
    func setupSubViews() {
        
        [titleLabel, subTitleLabel, emailTextField, idTextField, emailWarningLabel, idWarningLabel, authTimerLabel, goLoginButton, sendCheckLabel].forEach { addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            if screenHeight <= 568 {
                $0.top.equalToSuperview().inset(100)
            } else if screenHeight <= 667 && 568 < screenHeight {
                $0.top.equalToSuperview().inset(150)
            }
            else {
                $0.top.equalToSuperview().inset(208.0)
            }
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
        }
        
        idTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.leading)
            
            if screenHeight <= 568 {
                $0.top.equalTo(subTitleLabel.snp.bottom).offset(50)
            } else {
                $0.top.equalTo(subTitleLabel.snp.bottom).offset(93)
            }
            
        }
        
        idWarningLabel.snp.makeConstraints {
            $0.leading.equalTo(idTextField.snp.leading)
            $0.top.equalTo(idTextField.snp.bottom).offset(12.0)
        }
        
        emailTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(idWarningLabel.snp.bottom).offset(22)
        }
        
        emailWarningLabel.snp.makeConstraints {
            $0.leading.equalTo(emailTextField.snp.leading)
            $0.top.equalTo(emailTextField.snp.bottom).offset(12.0)
        }
        
        authTimerLabel.snp.makeConstraints {
            $0.centerX.equalTo(emailTextField.button)
            $0.bottom.equalTo(emailTextField.button.snp.top).offset(-5.0)
        }
        
        goLoginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(emailWarningLabel.snp.bottom).offset(79)
            $0.height.equalTo(48.0)
        }
        
        sendCheckLabel.snp.makeConstraints {
            $0.centerX.equalTo(goLoginButton)
            $0.bottom.equalTo(goLoginButton.snp.top).offset(-7.0)
        }
    }
}

extension FindPwView {
    
    @objc func goLoginButtonTapped(sender: UIButton!) {
        // Call the closure when the login button is tapped
        goLoginButtonActionHandler?()
    }
    
}
