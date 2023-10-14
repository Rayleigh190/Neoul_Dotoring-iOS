//
//  ReportReasonAlertView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/14.
//

import UIKit

class ReportReasonAlertView: UIView {
    
    private lazy var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    private lazy var statusBar: UIView = {
        let view = UIView()
        view.backgroundColor = .BaseWarningRed
        
        return view
    }()
    
    lazy var contentLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 17)
        label.text = "Content Text"
        label.numberOfLines = 1
        
        return label
    }()
    
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 6
        
        return stackView
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 17)
        button.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("접수", for: .normal)
        button.titleLabel?.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 17)
        button.backgroundColor = .BaseWarningRed
        button.setTitleColor(.white, for: .normal)
        
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
        setupSubViews()
        updateUI()
    }
    
}

private extension ReportReasonAlertView {
    
    func setupSubViews() {
        [alertView, contentLabel, buttonStackView].forEach {addSubview($0)}
        
        [statusBar].forEach {alertView.addSubview($0)}
        
        [cancelButton, confirmButton].forEach {buttonStackView.addArrangedSubview($0)}
        
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(304)
            $0.height.equalTo(356)
        }
        
        statusBar.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(47)
        }
        
        contentLabel.snp.makeConstraints {
            $0.centerX.equalTo(alertView)
            $0.centerY.equalTo(alertView).offset(-10)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.centerX.equalTo(alertView)
            $0.leading.equalTo(alertView.snp.leading).offset(8)
            $0.bottom.equalTo(alertView.snp.bottom).offset(-9)
        }
        
        cancelButton.snp.makeConstraints {
            $0.height.equalTo(36)
        }
        
        confirmButton.snp.makeConstraints {
            $0.height.equalTo(36)
        }
    }
    
    func updateUI() {
        alertView.layer.cornerRadius = 20
        alertView.clipsToBounds = true
        statusBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cancelButton.layer.cornerRadius = 18
        confirmButton.layer.cornerRadius = 18
    }
    
}
