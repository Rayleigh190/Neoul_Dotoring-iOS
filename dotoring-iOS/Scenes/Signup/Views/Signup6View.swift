//
//  Signup6View.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/24.
//

import UIKit

class Signup6View: UIView {

    // Add a closure property
    var loginButtonActionHandler: (() -> Void)?
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var navTitleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 14)
        var text = ""
        var attrRangeText = ""
        var attrStrColor = UIColor.label
        
        if uiStyle == .mento {
            text = "멘토로 회원가입"
            attrRangeText = "멘토"
            attrStrColor = .BaseGreen!
        } else {
            text = "멘티로 회원가입"
            attrRangeText = "멘티"
            attrStrColor = .BaseNavy!
        }
        
        label.text = text

        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.foregroundColor, value: attrStrColor, range: (text as NSString).range(of: attrRangeText))
        label.attributedText = attributedStr
        
        
        return label
    }()
    
    private lazy var stepBar: SignupStepBar = {
        if uiStyle == .mento {
            return SignupStepBar(stepCount: 6, currentStep: 6, style: .mento)
        } else {
            return SignupStepBar(stepCount: 6, currentStep: 6, style: .mentee)
        }
    }()
    
    private lazy var questionLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        let text = "Q. 계정 설정만 하면 끝이에요!"
        label.text = text
        var attrStrColor = UIColor.label
        if uiStyle == .mento {
            attrStrColor = .BaseGreen!
        } else {
            attrStrColor = .BaseNavy!
        }
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.foregroundColor, value: attrStrColor, range: (text as NSString).range(of: "계정"))
        label.attributedText = attributedStr
        
        return label
    }()
    
    private lazy var idAnswerLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "A. 아이디 설정하기"
        
        return label
    }()
    
    lazy var idTextField: LineTextField = {
        let textField = LineTextField()
        textField.isButtonVisible = true
        textField.textField.placeholder = "아이디"
        textField.button.setTitle("중복확인", for: .normal)
        textField.textField.returnKeyType = .continue
        
        return textField
    }()
    
    private lazy var idInfoLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 10)
        label.text = "영문과 숫자를 포함한 8-12글자로 표기해 주세요"
        label.textColor = .BaseSecondaryEmhasisGray
        
        return label
    }()
    
    private lazy var idWarningLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 10)
        label.text = "이미 있는 아이디입니다."
        label.textColor = .BaseWarningRed
        
        return label
    }()
    
    private lazy var pwAnswerLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "A. 비밀번호 설정하기"
        
        return label
    }()
    
    lazy var pwTextField: LineTextField = {
        let textField = LineTextField()
        textField.textField.placeholder = "비밀번호"
        textField.textField.returnKeyType = .continue
        
        return textField
    }()
    
    private lazy var pwInfoLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 10)
        label.text = "영문과 숫자, 특수문자를 포함한 7-12글자로 표기해 주세요."
        label.textColor = .BaseSecondaryEmhasisGray
        
        return label
    }()
    
    lazy var rePwTextField: LineTextField = {
        let textField = LineTextField()
        textField.textField.placeholder = "다시 한 번 써 주세요."
        textField.textField.returnKeyType = .continue
        
        return textField
    }()
    
    private lazy var pwWarningLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 10)
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
    
    private lazy var emailAnswerLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "A. 이메일 등록하기"
        
        return label
    }()
    
    lazy var emailTextField: LineTextField = {
        let textField = LineTextField()
        textField.isButtonVisible = true
        textField.textField.placeholder = "이메일"
        textField.button.setTitle("인증 코드 발송", for: .normal)
        textField.textField.returnKeyType = .continue
        
        return textField
    }()
    
    private lazy var authTimerLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 10)
        label.text = "05:00"
        label.textColor = .BaseWarningRed
        
        return label
    }()
    
    lazy var authCodeTextField: LineTextField = {
        let textField = LineTextField()
        textField.isButtonVisible = true
        textField.textField.placeholder = "인증 코드"
        textField.button.setTitle("인증하기", for: .normal)
        textField.textField.returnKeyType = .done
        
        return textField
    }()
    
    private lazy var authCodeWarningLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 10)
        label.text = "인증 코드가 달라요."
        label.textColor = .BaseWarningRed
        
        return label
    }()
    
    private lazy var loginButton: BaseButton = {
        let button = BaseButton(style: .gray)
        button.setTitle("로그인하러 가기", for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        return button
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

private extension Signup6View {
    
    func setupSubViews() {
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [navTitleLabel, stepBar, questionLabel, idAnswerLabel, idTextField, idInfoLabel, idWarningLabel, pwAnswerLabel, pwTextField, pwInfoLabel, rePwTextField, pwWarningLabel, pwChekButton, emailAnswerLabel, emailTextField, authTimerLabel,  authCodeTextField, authCodeWarningLabel, loginButton].forEach {contentView.addSubview($0)}
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().priority(.low)
        }
        
        navTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalToSuperview().offset(13)
        }
        
        stepBar.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalTo(navTitleLabel.snp.bottom).offset(87)
        }
        
        questionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalTo(stepBar.snp.bottom).offset(25)
        }
        
        idAnswerLabel.snp.makeConstraints {
            $0.leading.equalTo(questionLabel.snp.leading)
            $0.top.equalTo(questionLabel.snp.bottom).offset(66)
        }
        
        idTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(idAnswerLabel.snp.leading)
            $0.top.equalTo(idAnswerLabel.snp.bottom).offset(22)
        }
        
        idInfoLabel.snp.makeConstraints {
            $0.leading.equalTo(idTextField.snp.leading).offset(3)
            $0.top.equalTo(idTextField.snp.bottom).offset(12)
        }
        
        idWarningLabel.snp.makeConstraints {
            $0.leading.equalTo(idInfoLabel.snp.leading)
            $0.top.equalTo(idInfoLabel.snp.bottom).offset(2)
        }
        
        pwAnswerLabel.snp.makeConstraints {
            $0.leading.equalTo(idAnswerLabel.snp.leading)
            $0.top.equalTo(idWarningLabel.snp.bottom).offset(19)
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
            $0.trailing.equalTo(rePwTextField.snp.trailing)
        }
        
        emailAnswerLabel.snp.makeConstraints {
            $0.leading.equalTo(pwAnswerLabel.snp.leading)
            $0.top.equalTo(rePwTextField.snp.bottom).offset(48)
        }
        
        emailTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(emailAnswerLabel.snp.leading)
            $0.top.equalTo(emailAnswerLabel.snp.bottom).offset(28)
        }
        
        authTimerLabel.snp.makeConstraints {
            $0.centerX.equalTo(emailTextField.button)
            $0.top.equalTo(emailTextField.snp.bottom).offset(12)
        }
        
        authCodeTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(emailTextField.snp.leading)
            $0.top.equalTo(authTimerLabel.snp.bottom).offset(5)
        }
        
        authCodeWarningLabel.snp.makeConstraints {
            $0.leading.equalTo(authCodeTextField.snp.leading).offset(3)
            $0.top.equalTo(authCodeTextField.snp.bottom).offset(12)
        }
        
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalTo(authCodeWarningLabel.snp.bottom).offset(15)
            $0.height.equalTo(45)
        }
        
        
    }
}

extension Signup6View {
    
    @objc func loginButtonTapped(sender: UIButton!) {
        // Call the closure when the login button is tapped
        loginButtonActionHandler?()
    }
    
}
