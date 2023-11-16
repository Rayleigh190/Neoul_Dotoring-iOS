//
//  LoginView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/27.
//

import UIKit

final class LoginView: UIView {
    
    // Add a closure property
    var loginButtonActionHandler: (() -> Void)?
    var findIdButtonActionHandler: (() -> Void)?
    var findPwButtonActionHandler: (() -> Void)?
    var signupButtonActionHandler: (() -> Void)?
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private lazy var smallLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "SmallGrayDotoriLogoImg")

        return imageView
    }()
    
    private lazy var navTitle: NanumLabel = {
        let label = NanumLabel(weightType: .EB, size: 20)
        label.textColor = .BaseGray700
        label.text = "도토링"
        
        return label
    }()

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
        let text = "<전남대학교> 선배와 후배를\n한 공간에서 만나 보세요."
        label.text = text
        label.numberOfLines = 0
        
        let fontSize = UIFont.nanumSquare(style: .NanumSquareOTFEB, size: 28)
        let attributedStr = NSMutableAttributedString(string: text)

        attributedStr.addAttribute(.font, value: fontSize, range: (text as NSString).range(of: "한 공간에서"))
        label.attributedText = attributedStr
        
        return label
    }()
    
    private lazy var subTitleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .L, size: 13)
        label.textColor = .label
        label.text = "회원서비스 이용을 위해 로그인해 주세요."
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var idTextField: LineTextField = {
        let lineTextField = LineTextField()
        lineTextField.textField.returnKeyType = .continue
        
        // 폰트 및 스타일을 설정할 NSAttributedString 생성
       let placeholderText = "아이디"
       let placeholderAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.nanumSquare(style: .NanumSquareOTFR, size: 17),
        .foregroundColor: UIColor(red: 0.702, green: 0.702, blue: 0.702, alpha: 1) // 원하는 텍스트 색상으로 변경
       ]

       let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: placeholderAttributes)
        lineTextField.textField.attributedPlaceholder = attributedPlaceholder
        
        return lineTextField
    }()
    
    lazy var pwTextField: LineTextField = {
        let lineTextField = LineTextField()
        lineTextField.textField.returnKeyType = .done
        lineTextField.textField.isSecureTextEntry = true
        
        // 폰트 및 스타일을 설정할 NSAttributedString 생성
       let placeholderText = "비밀번호"
       let placeholderAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.nanumSquare(style: .NanumSquareOTFR, size: 17),
        .foregroundColor: UIColor(red: 0.702, green: 0.702, blue: 0.702, alpha: 1) // 원하는 텍스트 색상으로 변경
       ]

       let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: placeholderAttributes)
        lineTextField.textField.attributedPlaceholder = attributedPlaceholder
        
        return lineTextField
    }()
    
    private lazy var loginButton: BaseButton = {
        let button = BaseButton(style: .clear)
        button.setTitle("로그인", for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var autoLoginCheckBox: CheckBox = {
        let checkBout = CheckBox()
        checkBout.tintColor = .black
        
        return checkBout
    }()
    
    private lazy var autoLoginLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "자동 로그인"
        
        return label
    }()
    
    private lazy var autoLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(autoLoginButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var warningLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "존재하지 않는 계정입니다. 다시 입력해 주세요."
        label.textColor = .BaseWarningRed
        label.isHidden = true
        
        return label
    }()
    
    private lazy var accountStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 16
        
        return stack
    }()
    
    private lazy var findIdButton: UIButton = {
        let button = UIButton()
        button.setTitle("아이디 찾기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.nanumSquare(style: .NanumSquareOTFL, size: 15)
        button.addTarget(self, action: #selector(findIdButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var findPwButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 찾기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.nanumSquare(style: .NanumSquareOTFL, size: 15)
        button.addTarget(self, action: #selector(findPwButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.nanumSquare(style: .NanumSquareOTFL, size: 15)
        button.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var line1: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    private lazy var line2: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    private lazy var uiStyleSelectSwitch: UISwitch = {
        // UI 스타일 선택 스위치
        let switchButton = UISwitch()
        switchButton.subviews.first?.subviews.first?.backgroundColor = .BaseGreen
        switchButton.onTintColor = .BaseNavy
        switchButton.addTarget(self, action: #selector(uiStyleSelectSwitchTapped), for: UIControl.Event.valueChanged)
        switchButton.isHidden = true
        
        if uiStyle == .mento {
            switchButton.isOn = false
        } else {
            switchButton.isOn = true
        }
        
        return switchButton
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

private extension LoginView {
    
    func setupSubViews() {
        [navTitle, smallLogoImageView, backgroundImageView, titleLabel, subTitleLabel, idTextField, pwTextField, autoLoginCheckBox, autoLoginLabel, autoLoginButton, warningLabel, loginButton, accountStack, uiStyleSelectSwitch].forEach { addSubview($0) }
        
        [findIdButton, line1, findPwButton, line2, signupButton].forEach { accountStack.addArrangedSubview($0)}
        
        smallLogoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(65)
        }
        
        navTitle.snp.makeConstraints {
            $0.centerY.equalTo(smallLogoImageView)
            $0.leading.equalTo(smallLogoImageView.snp.trailing).offset(5.64)
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(00.0)
            $0.bottom.equalToSuperview().inset(73.66)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(smallLogoImageView).offset(99.61)
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
            $0.top.equalTo(idTextField.snp.bottom).offset(42)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        autoLoginCheckBox.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(pwTextField.snp.bottom).offset(20)
            $0.width.height.equalTo(15)
        }
        
        autoLoginLabel.snp.makeConstraints {
            $0.centerY.equalTo(autoLoginCheckBox)
            $0.leading.equalTo(autoLoginCheckBox.snp.trailing).offset(4.0)
        }
        
        autoLoginButton.snp.makeConstraints {
            $0.leading.equalTo(autoLoginCheckBox.snp.trailing)
            $0.trailing.equalTo(autoLoginLabel.snp.trailing)
            $0.centerY.equalTo(autoLoginLabel)
            $0.height.equalTo(18)
        }
        
        warningLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(loginButton.snp.top).offset(-7)
        }
        
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(pwTextField.snp.bottom).offset(96)
            $0.height.equalTo(48.0)
        }
        
        accountStack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(15.0)
            $0.height.equalTo(14.0)
        }
        
        line1.snp.makeConstraints {
            $0.width.equalTo(0.5)
        }
        
        line2.snp.makeConstraints {
            $0.width.equalTo(0.5)
        }
        
        uiStyleSelectSwitch.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(accountStack.snp.bottom).offset(20)
        }
        
    }
    
    
}

extension LoginView {
    
    @objc func loginButtonTapped(sender: UIButton!) {
        // Call the closure when the login button is tapped
        loginButtonActionHandler?()
    }
    
    @objc func findIdButtonTapped(sender: UIButton!) {
        // Call the closure when the login button is tapped
        findIdButtonActionHandler?()
    }
    
    @objc func findPwButtonTapped(sender: UIButton!) {
        // Call the closure when the login button is tapped
        findPwButtonActionHandler?()
    }
    
    @objc func signupButtonTapped(sender: UIButton!) {
        // Call the closure when the login button is tapped
        signupButtonActionHandler?()
    }
    
    // 자동 로그인 체크 박스 체크 상태 변경
    @objc func autoLoginButtonTapped(sender: UIButton!) {
        if autoLoginCheckBox.isChecked {
            autoLoginCheckBox.isChecked = false
        } else {
            autoLoginCheckBox.isChecked = true
        }
    }
    
    // UI 스타일 선택 스위치 버튼 클릭 되면 UIStyle 데이터 변경
    @objc func uiStyleSelectSwitchTapped(sender: UISwitch) {
        if sender.isOn {
            UserDefaults.standard.set("mentee", forKey: "UIStyle")
        } else {
            UserDefaults.standard.set("mento", forKey: "UIStyle")
        }
    }
    
}
