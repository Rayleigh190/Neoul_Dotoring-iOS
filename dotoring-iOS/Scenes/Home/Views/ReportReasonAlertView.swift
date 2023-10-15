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
    
    private lazy var statusBarLabel: NanumLabel = {
        let label = NanumLabel(weightType: .EB, size: 17)
        label.text = "신고 사유"
        
        return label
    }()
    
    lazy var contentLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 17)
        label.text = "Content Text"
        label.numberOfLines = 1
        
        return label
    }()
    
    private var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private var reason1Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 17)
        label.text = "낚시/도배"
        
        return label
    }()
    
    private var reason2Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 17)
        label.text = "유출/사칭/사기"
        
        return label
    }()
    
    private var reason3Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 17)
        label.text = "욕설/비하"
        
        return label
    }()
    
    private var reason4Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 17)
        label.text = "음란물/불건전한 만남 및 대화"
        
        return label
    }()
    
    private lazy var reason1Button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .gray
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
//        button.addTarget(self, action: #selector(agreeConfirmButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var reason2Button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .gray
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
//        button.addTarget(self, action: #selector(agreeConfirmButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var reason3Button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .gray
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
//        button.addTarget(self, action: #selector(agreeConfirmButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var reason4Button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .gray
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
//        button.addTarget(self, action: #selector(agreeConfirmButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var secondaryLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "신고가 접수 후엔 취소가 불가능합니다."
        label.textColor = .BaseSecondaryEmhasisGray
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
