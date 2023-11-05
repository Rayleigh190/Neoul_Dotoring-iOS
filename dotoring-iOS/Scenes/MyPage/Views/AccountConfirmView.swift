//
//  AccountConfirmView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/05.
//

import UIKit

class AccountConfirmView: UIView {

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "LoginBackgroundImg")

        return imageView
    }()
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 28)
        label.textColor = .label
        label.numberOfLines = 0
        var text = "계정 설정을 위해\n다시 로그인해 주세요."
        
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.font, value: UIFont.nanumSquare(style: .NanumSquareOTFEB, size: 28), range: (text as NSString).range(of: "다시"))
        
        label.attributedText = attributedStr
        
        return label
    }()
    
    private lazy var subTitleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.textColor = .BaseGray700
        label.text = "본인 확인을 위해 다시 로그인해 주세요."
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var idTextField: LineTextField = {
        let lineTextField = LineTextField()
        lineTextField.textField.placeholder = "아이디"
        lineTextField.textField.returnKeyType = .continue
        
        return lineTextField
    }()
    
    lazy var pwTextField: LineTextField = {
        let lineTextField = LineTextField()
        lineTextField.textField.placeholder = "비밀번호"
        lineTextField.textField.isSecureTextEntry = true
        lineTextField.textField.returnKeyType = .done
        
        return lineTextField
    }()
    
    lazy var loginButton: BaseButton = {
        let button = BaseButton(style: .clear)
        button.setTitle("로그인", for: .normal)
        
        return button
    }()
    
    private lazy var warningLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "존재하지 않는 계정입니다. 다시 입력해 주세요."
        label.textColor = .BaseWarningRed
        
        return label
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
//        updateUI()
    }
    
}

private extension AccountConfirmView {
        
    func setupSubViews() {
        [backgroundImageView, titleLabel, subTitleLabel, idTextField, pwTextField, warningLabel, loginButton].forEach { addSubview($0) }
        
        backgroundImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(00.0)
            $0.bottom.equalToSuperview().inset(73)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(185)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(6.0)
        }
        
        idTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(112)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        pwTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(idTextField.snp.bottom).offset(45.0)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        warningLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(loginButton.snp.top).offset(-10.0)
        }
        
        loginButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(pwTextField.snp.bottom).offset(96)
            $0.height.equalTo(48.0)
        }
        
    }
    
}
