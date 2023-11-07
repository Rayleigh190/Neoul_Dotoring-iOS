//
//  MentoringMethodSetViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/01.
//

import UIKit

/**
 * 마이페이지 > 멘토링 방식 설정
 * 멘토링 방식을 설정 할 수 있는 View입니다.
 * inputTextField에서 텍스트를 편집할 수 있습니다.
 */
class MentoringMethodSetView: UIView {
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 28)
        label.numberOfLines = 0
        var text = ""
        var attrRangeText = "어떤 멘토링"
        var attrStrColor = UIColor.label
        
        if uiStyle == .mento {
            text = "멘티들에게\n어떤 멘토링을 하고 싶은지 \n설명해 주세요!"
            attrStrColor = .BaseGreen!
        } else {
            text = "멘토들에게\n어떤 멘토링을 받고 싶은지 \n설명해 주세요!"
            attrStrColor = .BaseNavy!
        }
        
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.font, value: UIFont.nanumSquare(style: .NanumSquareOTFB, size: 28), range: (text as NSString).range(of: attrRangeText))
        attributedStr.addAttribute(.foregroundColor, value: attrStrColor, range: (text as NSString).range(of: attrRangeText))
        
        label.attributedText = attributedStr
        
        return label
    }()
    
    private lazy var infoLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "250자 이내로 제한됩니다."
        label.textColor = .BaseGray700
        
        return label
    }()
    
    lazy var inputTextField: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
        textView.textColor = .label
        textView.text = "기존 멘토링 방식"
        textView.isEditable = true
        textView.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 17)
        textView.layer.cornerRadius = 20
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 17, left: 13, bottom: 17, right: 13)
        
        return textView
    }()
    
    private lazy var inputCountLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 14)
        label.text = "\(inputTextField.text.count)/250"
        
        return label
    }()
    
    private lazy var cancelButton: BaseButton = {
        let button = BaseButton(style: .gray)
        button.setTitle("최소", for: .normal)
//        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var saveButton: BaseButton = {
        let button: BaseButton = {
            if uiStyle == .mento {
                return BaseButton(style: .green)
            } else {
                return BaseButton(style: .navy)
            }
        }()
        button.setTitle("저장하기", for: .normal)
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
        setupSubViews()
//        updateUI()
    }

}

private extension MentoringMethodSetView {
    
    func setupSubViews() {
        
        [titleLabel, infoLabel, inputTextField, inputCountLabel, cancelButton, saveButton].forEach {addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(178)
        }
        
        infoLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        inputTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(infoLabel.snp.leading)
            $0.top.equalTo(infoLabel.snp.bottom).offset(20)
        }
        
        inputCountLabel.snp.makeConstraints {
            $0.trailing.equalTo(inputTextField.snp.trailing)
            $0.top.equalTo(inputTextField.snp.bottom).offset(12)
        }
        
        saveButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(94)
            $0.height.equalTo(48)
        }
        
        cancelButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalTo(saveButton.snp.top).offset(-5)
            $0.height.equalTo(48)
        }
        
    }
    
}

extension MentoringMethodSetView {
    
    // inputTextField가 입력될 때마다 inputCountLabel을 업데이트 합니다.
    func updateCountLabel(characterCount: Int) {
        inputCountLabel.text = "\(characterCount)/250"
    }
    
}
