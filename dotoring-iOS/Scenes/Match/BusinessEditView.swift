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
    
    private lazy var radioButton1 = DefaultRadioButton()
    private lazy var radioButton2 = DefaultRadioButton()
    private lazy var radioButton3 = DefaultRadioButton()
    private lazy var radioButton4 = DefaultRadioButton()
    private lazy var radioButton5 = DefaultRadioButton()
    private lazy var radioButton6 = DefaultRadioButton()
    private lazy var radioButton7 = DefaultRadioButton()
    private lazy var radioButton8 = DefaultRadioButton()
    
    private lazy var businessNameRadioButtons = [radioButton1, radioButton2, radioButton3]
    private lazy var pjtGoalRadioButtons = [radioButton4, radioButton5, radioButton6, radioButton7, radioButton8]
    
    private lazy var businessNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = .systemBackground
        [title1Label, radioButton1, radioButton2, radioButton3].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    private lazy var pjtGoalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = .systemBackground
        [title2Label, radioButton4, radioButton5, radioButton6, radioButton7, radioButton8].forEach {
            stackView.addArrangedSubview($0)
        }
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
            return
        }
        
        if pjtGoalRadioButtons.contains(currentRadioButton) {
            pjtGoalRadioButtons.forEach { $0.isChecked = false }
            currentRadioButton.isChecked = !currentRadioButton.isChecked
        }
        
        
    }
}
