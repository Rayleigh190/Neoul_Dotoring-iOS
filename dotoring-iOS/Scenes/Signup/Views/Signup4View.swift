//
//  Signup4View.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/23.
//

import UIKit

class Signup4View: UIView {
    
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
        let bar = SignupStepBar(stepCount: 6, currentStep: 4)
        
        return bar
    }()
    
    private lazy var questionLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        let text = "Q. 멘토 님을 더 알고 싶어요!"
        label.text = text
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.BaseGreen!, range: (text as NSString).range(of: "멘토"))
        label.attributedText = attributedStr
        
        return label
    }()
    
    private lazy var questionDescriptionLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 10)
        label.text = "10자 이상, 80자 이하로 작성"
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var answerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 9
        
        return stackView
    }()
    
    private lazy var answerLabel1: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "A."
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    lazy var introductionInputTextField: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .BaseGray
        textView.textColor = .lightGray
        textView.text = "멘토 분야에 대해 소개해 주세요"
        textView.isEditable = true
        textView.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 15)
        textView.layer.cornerRadius = 20
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 17, left: 13, bottom: 17, right: 13)
        
        return textView
    }()
    
    private lazy var introductionInputWarningLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 14)
        label.text = "0/80"
        
        return label
    }()
    
    private lazy var nextButton: BaseButton = {
        let button = BaseButton(style: .gray)
        button.setTitle("다음", for: .normal)
//        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
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

private extension Signup4View {
    
    func setupSubViews() {
        [navTitleLabel, stepBar, questionLabel, questionDescriptionLabel, answerStackView, introductionInputWarningLabel, nextButton].forEach {addSubview($0)}
        
        answerStackView.addArrangedSubview(answerLabel1)
        answerStackView.addArrangedSubview(introductionInputTextField)
        
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
        
        introductionInputTextField.snp.makeConstraints {
            $0.height.equalTo(52).priority(.low)
        }
        
        answerStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(questionLabel.snp.leading)
            $0.top.equalTo(questionLabel.snp.bottom).offset(66)
        }

        introductionInputWarningLabel.snp.makeConstraints {
            $0.trailing.equalTo(answerStackView.snp.trailing)
            $0.top.equalTo(answerStackView.snp.bottom).offset(12)
        }

        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalToSuperview().offset(574)
            $0.height.equalTo(45)
        }
        
        
    }
}

extension Signup4View {
    
    // textView 입력될 때마다 라벨 업데이트
    func updateCountLabel(characterCount: Int) {
        introductionInputWarningLabel.text = "\(characterCount)/80"
    }
    
    @objc func nextButtonTapped(sender: UIButton!) {
        // Call the closure when the login button is tapped
        nextButtonActionHandler?()
    }
    
}
