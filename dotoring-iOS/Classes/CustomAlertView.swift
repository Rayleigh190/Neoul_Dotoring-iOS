//
//  CustomAlertView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/01.
//

import UIKit

class CustomAlertView: UIView {

    var hasSecondaryText: Bool = false
    var changeButtonPosition: Bool = false
    
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
        label.numberOfLines = 0
        
        // Define the line spacing (line height) you want, in points (e.g., 10 for 10 points). 행간 적용
        let lineSpacing: CGFloat = 6

        // Create a paragraph style with the desired line spacing.
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing

        // Create an attributed string with the paragraph style.
        let attributedText = NSMutableAttributedString(string: "Content Text")
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))

        // Apply the attributed text to the label.
        label.attributedText = attributedText
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var secondaryLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "secondary Text"
        label.textColor = .BaseGray700
        label.numberOfLines = 0
        label.textAlignment = .center
        
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
        button.setTitle("cancel button", for: .normal)
        button.titleLabel?.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 17)
        button.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("confirm button", for: .normal)
        button.titleLabel?.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 17)
        button.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    init(hasSecondaryText: Bool, changeButtonPosition: Bool) {
        super.init(frame: .zero)
        self.hasSecondaryText = hasSecondaryText
        self.changeButtonPosition = changeButtonPosition
        backgroundColor = .black.withAlphaComponent(0.5)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        cancelButton.layer.cornerRadius = cancelButton.frame.height/2
        confirmButton.layer.cornerRadius = confirmButton.frame.height/2
    }
    
    func setup() {
        setupSubViews()
        updateUI()
    }
    
}

private extension CustomAlertView {
    
    func setupSubViews() {
        [alertView, contentLabel, secondaryLabel, buttonStackView].forEach {addSubview($0)}
        
        [statusBar].forEach {alertView.addSubview($0)}
        
        if changeButtonPosition == true {
            [confirmButton, cancelButton].forEach {buttonStackView.addArrangedSubview($0)}
        } else {
            [cancelButton, confirmButton].forEach {buttonStackView.addArrangedSubview($0)}
        }
        
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(304)
            $0.height.equalTo(219)
        }
        
        statusBar.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(32)
        }
        
        if hasSecondaryText == true {
            contentLabel.snp.makeConstraints {
                $0.centerX.equalTo(alertView)
                $0.centerY.equalTo(alertView).offset(-20)
            }
        } else {
            contentLabel.snp.makeConstraints {
                $0.centerX.equalTo(alertView)
                $0.centerY.equalTo(alertView).offset(-10)
            }
        }
        
        secondaryLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(buttonStackView.snp.top).offset(-10)
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
    }
    
}
