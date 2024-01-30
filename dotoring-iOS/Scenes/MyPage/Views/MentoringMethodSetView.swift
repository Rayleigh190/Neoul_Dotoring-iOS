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
    var isChanged = false
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
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
        label.text = "10자 이상 250자 이내로 제한됩니다."
        label.textColor = .BaseGray700
        
        return label
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        [titleLabel, infoLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    lazy var inputTextField: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
        textView.textColor = .BaseGray600
        textView.text = "a. 멘토링 목표\n멘토링을 통해 얻고 싶은 점, 목표하는 바에 대해 적어 주세요.\n\nb. 멘토링 계획\n멘토링을 어떻게 운영할지 적어 주세요.\nex) 주에 2번, 비대면 멘토링\n\nc. 멘토링 성과\n멘토링을 통해 달성하고자 하는 성과를 적어 주세요.\nex) 관련 과목의 성적, 자격증 취득, 경진대회 참가 등의 구체적인 성과\n"
        textView.isEditable = true
        textView.font = UIFont.nanumSquare(style: .NanumSquareOTFB, size: 16)
        textView.layer.cornerRadius = 20
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 17, left: 13, bottom: 17, right: 13)
        
        return textView
    }()
    
    private lazy var inputCountLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 14)
        label.text = "\(inputTextField.text.count)/250"
        label.textAlignment = .right
        return label
    }()
    
    private lazy var middleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        
        [inputTextField, inputCountLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        
        let spaceView1 = UIView()
        spaceView1.snp.makeConstraints {
            $0.height.equalTo(70)
        }
        [topStackView, middleStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    lazy var cancelButton: BaseButton = {
        let button = BaseButton(style: .gray)
        button.setTitle("취소", for: .normal)
        
        return button
    }()
    
    lazy var saveButton: BaseButton = {
        let button = BaseButton(style: .gray)
        button.setTitle("저장하기", for: .normal)
        button.isEnabled = false
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        [cancelButton, saveButton].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
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

private extension MentoringMethodSetView {
    
    func setupSubViews() {
        [scrollView, buttonStackView].forEach {addSubview($0)}
        
        scrollView.addSubview(mainStackView)
                
        scrollView.snp.makeConstraints {
            $0.top.trailing.leading.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(buttonStackView.snp.top).offset(-10)
        }
        
        mainStackView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(17)
            $0.height.equalTo(buttonStackView.snp.width).multipliedBy(0.28)
        }
    }
    
}

extension MentoringMethodSetView {
    
    // inputTextField가 입력될 때마다 inputCountLabel을 업데이트 합니다.
    func updateCountLabel(characterCount: Int) {
        inputCountLabel.text = "\(characterCount)/250"
    }
    
}
