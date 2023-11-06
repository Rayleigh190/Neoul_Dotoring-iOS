//
//  PasswordResetView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/06.
//

import UIKit

/**
 * 마이페이지 > 계정 설정 > 비밀번호 재설정(버튼) > 계정확인 > 비밀번호 설정
 * 계정 비밀번호를 재설정하기 위한 View입니다.
 */
class PasswordResetView: UIView {
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 28)
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "새로운 계정 정보를\n입력해 주세요."
        
        return label
    }()
    
    private lazy var subTitleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.textColor = .BaseGray700
        label.text = "수정 후 다시 로그인해 주세요."
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var pwAnswerLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "비밀번호 설정하기"
        
        return label
    }()
    
    lazy var pwTextField: LineTextField = {
        let textField = LineTextField()
        textField.textField.placeholder = "비밀번호"
        textField.textField.returnKeyType = .continue
        
        return textField
    }()
    
    private lazy var pwInfoLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "영문과 숫자, 특수문자를 포함한 7-12글자로 표기해 주세요."
        label.textColor = .BaseGray700
        
        return label
    }()
    
    lazy var rePwTextField: LineTextField = {
        let textField = LineTextField()
        textField.textField.placeholder = "다시 한 번 써 주세요."
        textField.textField.returnKeyType = .done
        
        return textField
    }()
    
    private lazy var pwWarningLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "입력한 비밀번호와 달라요."
        label.textColor = .BaseWarningRed
        
        return label
    }()
    
    private lazy var pwChekButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .gray
        button.isUserInteractionEnabled = false
        
        return button
    }()
    
    lazy var reLoginButton: BaseButton = {
        let button: BaseButton = {
            if uiStyle == .mento {
                return BaseButton(style: .green)
            } else {
                return BaseButton(style: .navy)
            }
        }()
        
        button.setTitle("다시 로그인하기", for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
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

private extension PasswordResetView {
    
    func setupSubViews() {
        
        [titleLabel, subTitleLabel, pwAnswerLabel, pwTextField, pwInfoLabel, rePwTextField, pwWarningLabel, pwChekButton, reLoginButton].forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(185)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(6.0)
        }
        
        pwAnswerLabel.snp.makeConstraints {
            $0.leading.equalTo(subTitleLabel.snp.leading)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(49)
        }
        
        pwTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(pwAnswerLabel.snp.leading)
            $0.top.equalTo(pwAnswerLabel.snp.bottom).offset(25)
        }
        
        pwInfoLabel.snp.makeConstraints {
            $0.leading.equalTo(pwTextField.snp.leading).offset(3)
            $0.top.equalTo(pwTextField.snp.bottom).offset(12)
        }
        
        rePwTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(pwTextField.snp.leading)
            $0.top.equalTo(pwInfoLabel.snp.bottom).offset(10)
        }
        
        pwWarningLabel.snp.makeConstraints {
            $0.leading.equalTo(rePwTextField.snp.leading).offset(3)
            $0.top.equalTo(rePwTextField.snp.bottom).offset(12)
        }
        
        pwChekButton.snp.makeConstraints {
            $0.centerY.equalTo(rePwTextField)
            $0.trailing.equalTo(rePwTextField.snp.trailing).offset(-4.5)
        }
        
        reLoginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(78)
            $0.height.equalTo(48.0)
        }

    }
    
}
