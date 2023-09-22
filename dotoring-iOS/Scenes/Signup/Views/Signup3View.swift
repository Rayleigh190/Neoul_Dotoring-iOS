//
//  Signup3View.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/22.
//

import UIKit

class Signup3View: UIView {
    
    // Add a closure property
    var nextButtonActionHandler: (() -> Void)?

    private lazy var navTitleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 14)
        let text = "멘토로 회원가입"
        label.text = text
        // 멘티일 경우 파란색으로 하기
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.BaseGreen!, range: (text as NSString).range(of: "멘토"))
        label.attributedText = attributedStr
        
        return label
    }()
    
    private lazy var stepBar: SignupStepBar = {
        let bar = SignupStepBar(stepCount: 6, currentStep: 3)
        
        return bar
    }()
    
    private lazy var questionLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        let text = "Q. 어떻게 불러드릴까요?"
        label.text = text
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.BaseGreen!, range: (text as NSString).range(of: "어떻게"))
        label.attributedText = attributedStr
        
        return label
    }()
    
    private lazy var questionDescriptionLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 10)
        label.text = "3자 이상, 8자 이하, 숫자 1개 이상 입력하여 작성"
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var answerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 14
        
        return stackView
    }()
    
    private lazy var answerLabel1: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "A."
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    private lazy var nickNameTextField: LineTextField = {
        let textField = LineTextField()
        textField.isButtonVisible = true
        textField.textField.placeholder = "닉네임"
        textField.button.setTitle("중복확인", for: .normal)
        
        
        return textField
    }()
    
    private lazy var nickNameWarningLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 10)
        label.text = "이미 있는 닉네임입니다."
        label.textColor = .BaseWarningRed
        
        return label
    }()
    
    private lazy var answerLabel2: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "라고 불러주세요."
        
        return label
    }()
    
    private lazy var nextButton: BaseButton = {
        let button = BaseButton(style: .gray)
        button.setTitle("다음", for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
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
//        updateUI()
        setupSubViews()
    }

}

private extension Signup3View {
    
    func setupSubViews() {
        [navTitleLabel, stepBar, questionLabel, questionDescriptionLabel, answerStackView,  nickNameWarningLabel, answerLabel2, nextButton].forEach {addSubview($0)}
        
        answerStackView.addArrangedSubview(answerLabel1)
        answerStackView.addArrangedSubview(nickNameTextField)
        
        navTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalToSuperview().offset(104)
        }
        
        stepBar.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalTo(navTitleLabel.snp.bottom).offset(87)
        }
        
        questionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalTo(stepBar.snp.bottom).offset(25)
        }
        
        questionDescriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(questionLabel.snp.leading).offset(20)
            $0.top.equalTo(questionLabel.snp.bottom).offset(5)
        }
        
        answerStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(questionLabel.snp.leading)
            $0.top.equalTo(questionLabel.snp.bottom).offset(66)
        }
        
        nickNameWarningLabel.snp.makeConstraints {
            $0.leading.equalTo(nickNameTextField.snp.leading)
            $0.top.equalTo(answerStackView.snp.bottom).offset(12)
        }

        answerLabel2.snp.makeConstraints {
            $0.leading.equalTo(nickNameTextField.snp.leading)
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(40)
        }

        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalTo(answerLabel2.snp.bottom).offset(55)
            $0.height.equalTo(45)
        }
        
        
    }
}

extension Signup3View {
    
    @objc func nextButtonTapped(sender: UIButton!) {
        // Call the closure when the login button is tapped
        nextButtonActionHandler?()
    }
    
}
