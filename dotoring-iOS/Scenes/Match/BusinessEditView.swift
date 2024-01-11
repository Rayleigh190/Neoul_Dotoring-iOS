//
//  BusinessEditView.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/8/24.
//

import UIKit

class BusinessEditView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var title1Label: NanumLabel = {
        let label = NanumLabel(weightType: .EB, size: 17)
        label.text = "지원사업명"
        return label
    }()
    
    private lazy var title2Label: NanumLabel = {
        let label = NanumLabel(weightType: .EB, size: 17)
        label.text = "프로젝트 목표"
        return label
    }()
    
    private lazy var etcTextField1: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.isEnabled = false
        textField.placeholder = "(18자 이내 직접 입력)"
        return textField
    }()
    
    private lazy var etcTextField2: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.isEnabled = false
        textField.placeholder = "(10자 이내 직접 입력)"
        return textField
    }()
    
    private lazy var radioButton1 = DefaultRadioButton(text: "교학상장")
    private lazy var radioButton2 = DefaultRadioButton(text: "캡스톤디자인")
    private lazy var radioButton3 = DefaultRadioButton(text: "기타")
    private lazy var radioButton4 = DefaultRadioButton(text: "공모전")
    private lazy var radioButton5 = DefaultRadioButton(text: "학업")
    private lazy var radioButton6 = DefaultRadioButton(text: "대외활동")
    private lazy var radioButton7 = DefaultRadioButton(text: "학교 생활")
    private lazy var radioButton8 = DefaultRadioButton(text: "기타")
    
    private lazy var businessNameRadioButtons = [radioButton1, radioButton2, radioButton3]
    private lazy var pjtGoalRadioButtons = [radioButton4, radioButton5, radioButton6, radioButton7, radioButton8]
    
    private lazy var businessNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = .systemBackground
        stackView.spacing = 10
        [title1Label, radioButton1, radioButton2, radioButton3].forEach {
            let subStackView = UIStackView()
            subStackView.axis = .horizontal
            subStackView.distribution = .fill
            subStackView.spacing = 5
            subStackView.addArrangedSubview($0)
            if $0 == radioButton3 {
                $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                etcTextField1.setContentHuggingPriority(.defaultLow, for: .horizontal)
                subStackView.addArrangedSubview(etcTextField1)
            } else {
                let spaceView = UIView()
                spaceView.setContentHuggingPriority(.defaultLow, for: .horizontal)
                subStackView.addArrangedSubview(spaceView)
            }
            
            stackView.addArrangedSubview(subStackView)
        }
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 17, bottom: 20, right: 17)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var pjtGoalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = .systemBackground
        stackView.spacing = 10
        stackView.addArrangedSubview(title2Label)
        let radioButtons = [radioButton4, radioButton5, radioButton6, radioButton7, radioButton8]
        for i in stride(from: 0, to: radioButtons.count, by: 2) {
            // 두 개의 radioButton를 가지는 subStackView
            let subStackView = UIStackView()
            subStackView.axis = .horizontal
            subStackView.distribution = .fillEqually
            subStackView.alignment = .fill
            
            for k in i...i+1 {
                if k < radioButtons.count {
                    // radio버튼과 빈뷰를 나누는 스택뷰
                    let subSubStackView = UIStackView()
                    subSubStackView.axis = .horizontal
                    subSubStackView.distribution = .fill
                    subSubStackView.spacing = 5
                    subSubStackView.addArrangedSubview(radioButtons[k])
                    
                    if radioButtons[k] == radioButton8 {
                        radioButtons[k].setContentHuggingPriority(.defaultHigh, for: .horizontal)
                        etcTextField2.setContentHuggingPriority(.defaultLow, for: .horizontal)
                        subSubStackView.addArrangedSubview(etcTextField2)
                    } else {
                        let spaceView = UIView()
                        spaceView.setContentHuggingPriority(.defaultLow, for: .horizontal)
                        subSubStackView.addArrangedSubview(spaceView)
                    }
                    subStackView.addArrangedSubview(subSubStackView)
                }
            }
            stackView.addArrangedSubview(subStackView)
        }
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 17, bottom: 20, right: 17)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var introTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        
        let titleLabel = NanumLabel(weightType: .EB, size: 17)
        titleLabel.text = "소개"
        titleLabel.textColor = .BaseGray900
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        let subTitleLabel = NanumLabel(weightType: .R, size: 13)
        subTitleLabel.text = "진행하려고 하는 프로젝트에 대해 소개해 주세요."
        subTitleLabel.textColor = .BaseGray600
        
        [titleLabel, subTitleLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    private lazy var introAnswerATextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .BaseGray200
        textView.textColor = .BaseGray900
        textView.isEditable = true
        textView.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 15)
        textView.layer.cornerRadius = 20
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 17, left: 13, bottom: 17, right: 13)
        
        return textView
    }()
    
    private lazy var introAnswerAStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        
        let answerLabel = NanumLabel(weightType: .R, size: 13)
        answerLabel.text = "a. 프로젝트를 하게 된 이유"
        answerLabel.textColor = .BaseGray900
        [answerLabel, introAnswerATextView].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    private lazy var introAnswerBTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .BaseGray200
        textView.textColor = .lightGray
        textView.text = "ex) 일주일에 한 번, 비대면으로 진행하고 싶어요."
        textView.isEditable = true
        textView.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 15)
        textView.layer.cornerRadius = 20
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 17, left: 13, bottom: 17, right: 13)
        
        return textView
    }()
    
    private lazy var introAnswerBStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        
        let answerLabel = NanumLabel(weightType: .R, size: 13)
        answerLabel.text = "b. 진행 방식"
        answerLabel.textColor = .BaseGray900
        [answerLabel, introAnswerBTextView].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    private lazy var introAnswerCTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .BaseGray200
        textView.textColor = .lightGray
        textView.text = "ex) 알고리즘을 공부하는 사람들과 함께하고 싶어요."
        textView.isEditable = true
        textView.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 15)
        textView.layer.cornerRadius = 20
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 17, left: 13, bottom: 17, right: 13)
        
        return textView
    }()
    
    private lazy var introAnswerCStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        
        let answerLabel = NanumLabel(weightType: .R, size: 13)
        answerLabel.text = "c. 모집 팀원"
        answerLabel.textColor = .BaseGray900
        [answerLabel, introAnswerCTextView].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    private lazy var introStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = .systemBackground
        stackView.spacing = 12
        
        [introTitleStackView, introAnswerAStackView, introAnswerBStackView, introAnswerCStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 17, bottom: 20, right: 17)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var personnelTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        
        let titleLabel = NanumLabel(weightType: .EB, size: 17)
        titleLabel.text = "필요 인원"
        titleLabel.textColor = .BaseGray900
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        let subTitleLabel = NanumLabel(weightType: .R, size: 13)
        subTitleLabel.text = "현재 참여 인원/총 인원 (최대 9)"
        subTitleLabel.textColor = .BaseGray600
        
        [titleLabel, subTitleLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    private lazy var leftPersonnelTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .BaseGray200
        textView.textColor = .lightGray
        textView.text = "0"
        textView.isEditable = true
        textView.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 15)
        textView.layer.cornerRadius = 20
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 17, left: 13, bottom: 17, right: 13)
        textView.keyboardType = .numberPad
        textView.textAlignment = .center
        textView.snp.makeConstraints {$0.width.equalTo(60)}
        return textView
    }()
    
    private lazy var rightPersonnelTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .BaseGray200
        textView.textColor = .lightGray
        textView.text = "0"
        textView.isEditable = true
        textView.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 15)
        textView.layer.cornerRadius = 20
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 17, left: 13, bottom: 17, right: 13)
        textView.keyboardType = .numberPad
        textView.textAlignment = .center
        textView.snp.makeConstraints {$0.width.equalTo(60)}
        return textView
    }()
    
    private lazy var personnelInputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 7
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "line.diagonal")
        imageView.tintColor = .BaseGray900
        
        let spaceView = UIView()
        spaceView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        [leftPersonnelTextView, imageView, rightPersonnelTextView, spaceView].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    private lazy var personnelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .systemBackground
        stackView.spacing = 10
        [personnelTitleStackView, personnelInputStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 17, bottom: 20, right: 17)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        setup()
        businessNameRadioButtons.forEach { $0.delegate = self}
        pjtGoalRadioButtons.forEach { $0.delegate = self}
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }
    
    func setup() {
        [introAnswerATextView, introAnswerBTextView, introAnswerCTextView, leftPersonnelTextView, rightPersonnelTextView].forEach {$0.delegate = self}
        setupSubViews()
    }
}

private extension BusinessEditView {
    
    func setupSubViews() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        stackView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        [businessNameStackView, pjtGoalStackView, introStackView, personnelStackView].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func updateUI() {
        
    }
}

extension BusinessEditView: RadioButtonDelegate {
    func onClick(_ sender: UIView) {
        guard let currentRadioButton = sender as? DefaultRadioButton else {
            return
        }
        
        if businessNameRadioButtons.contains(currentRadioButton) {
            businessNameRadioButtons.forEach { $0.isChecked = false } // 모두 선택 해제
            currentRadioButton.isChecked = !currentRadioButton.isChecked
            if currentRadioButton == radioButton3 {
                etcTextField1.isEnabled = true
                etcTextField1.backgroundColor = .BaseGray200
            } else {
                etcTextField1.isEnabled = false
                etcTextField1.backgroundColor = .systemBackground
                etcTextField1.text = ""
            }
        }
        
        if pjtGoalRadioButtons.contains(currentRadioButton) {
            pjtGoalRadioButtons.forEach { $0.isChecked = false }
            currentRadioButton.isChecked = !currentRadioButton.isChecked
            if currentRadioButton == radioButton8 {
                etcTextField2.isEnabled = true
                etcTextField2.backgroundColor = .BaseGray200
            } else {
                etcTextField2.isEnabled = false
                etcTextField2.backgroundColor = .systemBackground
                etcTextField2.text = ""
            }
        }
    }
}

extension BusinessEditView: UITextViewDelegate {
    // textView 포커싱 됐을 때 placeholder text 지우기
    func textViewDidBeginEditing(_ textView: UITextView) {
        let text = ["ex) 일주일에 한 번, 비대면으로 진행하고 싶어요.", "ex) 알고리즘을 공부하는 사람들과 함께하고 싶어요.", "0"]
        if textView == introAnswerBTextView || textView == introAnswerCTextView || textView == leftPersonnelTextView || textView == rightPersonnelTextView {
            if text.contains(textView.text) {
                textView.text = nil
                textView.textColor = .BaseGray900
            }
        }
    }
    
    // textView 포커싱 끝났을 때 빈칸이면 placeholder text 채우기
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            if textView == introAnswerBTextView {
                textView.text = "ex) 일주일에 한 번, 비대면으로 진행하고 싶어요."
            } else if textView == introAnswerCTextView {
                textView.text = "ex) 알고리즘을 공부하는 사람들과 함께하고 싶어요."
            }
            textView.textColor = .lightGray
        }
    }
    
    // textView 글자수 제한
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == leftPersonnelTextView || textView == rightPersonnelTextView {
            let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
            guard let oldString = textView.text, let newRange = Range(range, in: oldString) else { return true }
            let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)

            let characterCount = newString.count
            guard characterCount <= 1 else { return false }
        }
        return true
    }
}
