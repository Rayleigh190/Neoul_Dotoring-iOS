//
//  Signup5View.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/24.
//

import UIKit

class Signup5View: UIView {
    
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
        let bar = SignupStepBar(stepCount: 6, currentStep: 5)
        
        return bar
    }()
    
    private lazy var questionLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        let text = "Q. 이 점은 유의해 주세요."
        label.text = text
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.BaseGreen!, range: (text as NSString).range(of: "유의"))
        label.attributedText = attributedStr
        
        return label
    }()
    
    private lazy var questionDescriptionLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 10)
        label.text = "동의하지 않으시면 가입이 제한됩니다."
        label.textColor = .gray
        
        return label
    }()
    
    lazy var personalInfoTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .BaseGray
        textView.textColor = .black
        textView.text = "개인정보 관련 내용"
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.font = UIFont.nanumSquare(style: .NanumSquareOTFL, size: 12)
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 23, bottom: 8, right: 23)
        
        return textView
    }()
    
    private lazy var answerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 0
        
        return stackView
    }()
    
    private lazy var answerLabel1: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "A. 동의합니다."
        
        return label
    }()
    
    private lazy var agreeConfirmButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .gray
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        button.addTarget(self, action: #selector(agreeConfirmButtonTapped), for: .touchUpInside)
        
        return button
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
    
    override func layoutSubviews() {
        // 뷰의 레이아웃이 업데이트되고 난 후
        super.layoutSubviews()
        updateUI()
    }
    
    func setup() {
        setupSubViews()
    }

}

private extension Signup5View {
    
    func setupSubViews() {
        [navTitleLabel, stepBar, questionLabel, questionDescriptionLabel, personalInfoTextView, answerStackView, nextButton].forEach {addSubview($0)}
        
        answerStackView.addArrangedSubview(answerLabel1)
        answerStackView.addArrangedSubview(agreeConfirmButton)
        
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
        
        personalInfoTextView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(questionLabel.snp.leading)
            $0.top.equalTo(questionLabel.snp.bottom).offset(35)
            $0.height.equalTo(11).priority(.low)
        }
        
        answerStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(personalInfoTextView.snp.leading)
            $0.top.equalTo(personalInfoTextView.snp.bottom).offset(76)
        }

        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalToSuperview().offset(574)
            $0.height.equalTo(45)
        }
        
        
    }
}

extension Signup5View {
    
    func updateUI() {
        // personalInfoTextView 모서리 둥글게
        personalInfoTextView.layer.cornerRadius = personalInfoTextView.frame.height / 2
        personalInfoTextView.clipsToBounds = true
    }
    
    // agreeConfirmButton 클릭심 마다 체크마크 색 변하게
    @objc func agreeConfirmButtonTapped(sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            sender.tintColor = .BaseGreen
        } else {
            sender.tintColor = .gray
        }
    }
    
    @objc func nextButtonTapped(sender: UIButton!) {
        // Call the closure when the login button is tapped
        nextButtonActionHandler?()
    }
    
}

