//
//  Signup3View.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/22.
//

import UIKit

class Signup3View: UIView {
    
    // 뷰 전체 높이 길이
    let screenHeight = UIScreen.main.bounds.size.height
    
    // Add a closure property
    var nextButtonActionHandler: (() -> Void)?
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private lazy var stepBar: SignupStepBar = {
        if uiStyle == .mento {
            return SignupStepBar(stepCount: 6, currentStep: 3, style: .mento)
        } else {
            return SignupStepBar(stepCount: 6, currentStep: 3, style: .mentee)
        }
    }()
    
    private lazy var questionLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 24)
        let text = "Q. 어떻게 불러드릴까요?"
        label.text = text
        var attrStrColor = UIColor.label
        if uiStyle == .mento {
            attrStrColor = .BaseGreen!
        } else {
            attrStrColor = .BaseNavy!
        }
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.foregroundColor, value: attrStrColor, range: (text as NSString).range(of: "어떻게"))
        label.attributedText = attributedStr
        
        return label
    }()
    
    private lazy var questionDescriptionLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "3자 이상, 8자 이하, 숫자 1개 이상 입력하여 작성"
        label.textColor = .BaseGray600
        
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
    
    lazy var nickNameTextField: LineTextField = {
        let textField = LineTextField()
        textField.isButtonVisible = true
        textField.textField.placeholder = "닉네임"
        textField.button.setTitle("중복확인", for: .normal)
        
        
        return textField
    }()
    
    lazy var nickNameWarningLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "이미 있는 닉네임입니다."
        label.textColor = .BaseWarningRed
        label.isHidden = true
        
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
        [stepBar, questionLabel, questionDescriptionLabel, answerStackView,  nickNameWarningLabel, answerLabel2, nextButton].forEach {addSubview($0)}
        
        answerStackView.addArrangedSubview(answerLabel1)
        answerStackView.addArrangedSubview(nickNameTextField)

        
        stepBar.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(17)
            if screenHeight <= 568 {
                $0.top.equalToSuperview().inset(70)
            } else {
                $0.top.equalToSuperview().offset(147).priority(.low)
                $0.top.greaterThanOrEqualToSuperview().inset(30).priority(.required)
            }
        }
        
        questionLabel.snp.makeConstraints {
            $0.leading.equalTo(stepBar.snp.leading)
            $0.top.equalTo(stepBar.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(17)
        }
        
        questionDescriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(questionLabel.snp.leading).offset(20)
            $0.top.equalTo(questionLabel.snp.bottom).offset(5)
        }
        
        answerStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(questionLabel.snp.leading)
            $0.top.equalTo(questionLabel.snp.bottom).offset(65)
        }
        
        nickNameWarningLabel.snp.makeConstraints {
            $0.leading.equalTo(nickNameTextField.snp.leading)
            $0.top.equalTo(answerStackView.snp.bottom).offset(12)
        }

        answerLabel2.snp.makeConstraints {
            $0.trailing.equalTo(nickNameTextField.snp.trailing)
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(35)
        }

        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(questionLabel.snp.leading)
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
