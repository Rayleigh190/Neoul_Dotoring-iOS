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
        
        [businessNameStackView, pjtGoalStackView].forEach {
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
