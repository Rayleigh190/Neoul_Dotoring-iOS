//
//  CustomAlertView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/01.
//

import UIKit

class CustomAlertView: UIView {
    
    private lazy var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    private lazy var contentLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "Content Text"
        
        return label
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("cancel button", for: .normal)
        button.backgroundColor = .red
        
        return button
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("confirm button", for: .normal)
        button.backgroundColor = .blue
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black.withAlphaComponent(0.5)
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

private extension CustomAlertView {
    
    func setupSubViews() {
        [alertView, contentLabel, buttonStackView].forEach {addSubview($0)}
        
        [cancelButton, confirmButton].forEach {buttonStackView.addArrangedSubview($0)}
        
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(304)
            $0.height.equalTo(219)
        }
        
        contentLabel.snp.makeConstraints {
            $0.center.equalTo(alertView)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.centerX.equalTo(alertView)
            $0.leading.equalTo(alertView.snp.leading)
            $0.bottom.equalTo(alertView.snp.bottom)
        }
    }
    
}
