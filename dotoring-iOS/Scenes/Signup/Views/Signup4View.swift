//
//  Signup4View.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/23.
//

import UIKit

class Signup4View: UIView {
    
    // 뷰 전체 높이 길이
    let screenHeight = UIScreen.main.bounds.size.height
    
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
            return SignupStepBar(stepCount: 6, currentStep: 4, style: .mento)
        } else {
            return SignupStepBar(stepCount: 6, currentStep: 4, style: .mentee)
        }
    }()
    
    private lazy var questionLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 24)
        var text = ""
        var attrRangeText = ""
        var attrStrColor = UIColor.label
        
        if uiStyle == .mento {
            text = "Q. 멘토 님을 더 알고 싶어요!"
            attrRangeText = "멘토"
            attrStrColor = .BaseGreen!
        } else {
            text = "Q. 멘티 님을 더 알고 싶어요!"
            attrRangeText = "멘티"
            attrStrColor = .BaseNavy!
        }
        label.text = text
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.foregroundColor, value: attrStrColor, range: (text as NSString).range(of: attrRangeText))
        label.attributedText = attributedStr
        
        return label
    }()
    
    private lazy var questionDescriptionLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "본인에 대해서 3개 이하 태그로 작성, 글자수 6자 이하\nex)#AOS_개발"
        label.textColor = .BaseGray600
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var answerLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "A."
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    lazy var tagStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 9
        
        return stackView
    }()
    
    lazy var tag1TextField: TagTextField = {
        let textField = TagTextField()
        
        return textField
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

private extension Signup4View {
    
    func setupSubViews() {
        [stepBar, questionLabel, questionDescriptionLabel, answerLabel, tagStackView, nextButton].forEach {addSubview($0)}
        
        [tag1TextField].forEach { tagStackView.addArrangedSubview($0) }
        
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
            $0.trailing.equalTo(questionLabel.snp.trailing)
        }
        
        answerLabel.snp.makeConstraints {
            $0.leading.equalTo(questionLabel.snp.leading)
            $0.top.equalTo(questionLabel.snp.bottom).offset(66)
        }
        
        tagStackView.snp.makeConstraints {
            $0.leading.equalTo(answerLabel.snp.trailing).offset(10)
            $0.top.equalTo(answerLabel.snp.top)
            $0.width.equalTo(150)
        }
        
        [tag1TextField].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(40)
            }
        }

        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(questionLabel.snp.leading)
            $0.top.equalTo(tagStackView.snp.bottom).offset(55)
            $0.height.equalTo(nextButton.snp.width).multipliedBy(0.14)
        }
        
        
    }
}

extension Signup4View {
    
    @objc func nextButtonTapped(sender: UIButton!) {
        nextButtonActionHandler?()
    }
    
}
