//
//  BusinessDetailAlertView.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/14/24.
//

import UIKit

class BusinessDetailAlertView: UIView {
    // 뷰 전체 높이 길이
    let screenHeight = UIScreen.main.bounds.size.height
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 28)
        label.text = "본인이 어떤 사람인지\n소개해 주세요!"
        label.numberOfLines = 0
        
        let fontSize = UIFont.nanumSquare(style: .NanumSquareOTFEB, size: 28)
        let attributedStr = NSMutableAttributedString(string: label.text!)

        attributedStr.addAttribute(.font, value: fontSize, range: (label.text! as NSString).range(of: "소개"))
        label.attributedText = attributedStr
        return label
    }()
    
    private lazy var subTitleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "프로필과 함께 해당 내용이 채팅으로 전송됩니다."
        label.textColor = .BaseGray700
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        [titleLabel, subTitleLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .BaseGray200
        textView.textColor = .lightGray
        textView.isEditable = true
        textView.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 16)
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 17, left: 15, bottom: 17, right: 15)
        textView.text = "저는\na. 이런 성향을 갖고 있어요\nb. 이런 활동을 하고 싶어요\nc. 이런 것들을 잘해요"
        return textView
    }()
    
    lazy var cancelButton: BaseButton = {
        let button = BaseButton(style: .gray)
        button.setTitle("취소", for: .normal)
        return button
    }()
    
    lazy var sendButton: BaseButton = {
        let button = BaseButton(style: .green)
        button.setTitle("전송하기", for: .normal)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        [cancelButton, sendButton].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    private lazy var windowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .systemBackground
        stackView.axis = .vertical
        stackView.spacing = 17
        stackView.layoutMargins = UIEdgeInsets(top: 30, left: 22, bottom: 20, right: 22)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        let spaceView = UIView()
        spaceView.backgroundColor = .red
        spaceView.snp.makeConstraints {$0.height.equalTo(50)}
        
        [titleStackView, textView, buttonStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor =  UIColor(red: 0.004, green: 0.004, blue: 0.004, alpha: 0.35)
        textView.delegate = self
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }
    
    func setup() {
        setupSubViews()
    }
}

private extension BusinessDetailAlertView {
    func updateUI() {
        textView.layer.cornerRadius = textView.frame.height * 0.164
        windowStackView.layer.cornerRadius = windowStackView.frame.height * 0.059
    }
    
    func setupSubViews() {
        [windowStackView].forEach {
            addSubview($0)
        }
        
        textView.snp.makeConstraints {
            $0.height.lessThanOrEqualTo(screenHeight/2)
        }
        
        cancelButton.snp.makeConstraints {
            $0.height.equalTo(cancelButton.snp.width).multipliedBy(0.309)
        }
        
        sendButton.snp.makeConstraints {
            $0.height.equalTo(sendButton.snp.width).multipliedBy(0.309)
        }
        
        windowStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
    }
}

extension BusinessDetailAlertView: UITextViewDelegate {
    // textView 포커싱 됐을 때 placeholder text 지우기
    func textViewDidBeginEditing(_ textView: UITextView) {
        let text = ["저는\na. 이런 성향을 갖고 있어요\nb. 이런 활동을 하고 싶어요\nc. 이런 것들을 잘해요"]
        if textView == self.textView{
            if text.contains(textView.text) {
                textView.text = nil
                textView.textColor = .BaseGray900
            }
        }
    }
}
