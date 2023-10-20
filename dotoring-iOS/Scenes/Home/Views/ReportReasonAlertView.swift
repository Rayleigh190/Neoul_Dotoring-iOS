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
        label.textColor = .white
        label.text = "신고 사유"
        
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
        label.text = " 낚시/도배"
        
        return label
    }()
    
    private lazy var reason1Button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .gray
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        button.addTarget(self, action: #selector(reasonButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var reason1StackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 0
        
        [reason1Label, reason1Button].forEach {stackView.addArrangedSubview($0)}
        
        return stackView
    }()
    
    private var reason2Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 17)
        label.text = " 유출/사칭/사기"
        
        return label
    }()
    
    private lazy var reason2Button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .gray
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        button.addTarget(self, action: #selector(reasonButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var reason2StackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 0
        [reason2Label, reason2Button].forEach {stackView.addArrangedSubview($0)}
        
        return stackView
    }()
    
    private var reason3Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 17)
        label.text = " 욕설/비하"
        
        return label
    }()
    
    private lazy var reason3Button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .gray
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        button.addTarget(self, action: #selector(reasonButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var reason3StackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 0
        [reason3Label, reason3Button].forEach {stackView.addArrangedSubview($0)}
        
        return stackView
    }()
    
    private var reason4Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 17)
        label.text = " 음란물/불건전한 만남 및 대화"
        
        return label
    }()

    private lazy var reason4Button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .gray
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        button.addTarget(self, action: #selector(reasonButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var reason4StackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 0
        [reason4Label, reason4Button].forEach {stackView.addArrangedSubview($0)}
        
        return stackView
    }()
    
    private lazy var dashedLine1View: DashedLineView = {
        let line = DashedLineView()
        
        return line
    }()
    
    private lazy var dashedLine2View: DashedLineView = {
        let line = DashedLineView()
        
        return line
    }()
    
    private lazy var dashedLine3View: DashedLineView = {
        let line = DashedLineView()
        
        return line
    }()
    
    private lazy var dashedLine4View: DashedLineView = {
        let line = DashedLineView()
        
        return line
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
        [alertView, buttonStackView].forEach {addSubview($0)}
        
        [statusBar, contentStackView, secondaryLabel].forEach {alertView.addSubview($0)}
        
        statusBar.addSubview(statusBarLabel)
        
        [reason1StackView, dashedLine1View, reason2StackView, dashedLine2View, reason3StackView, dashedLine3View, reason4StackView, dashedLine4View].forEach { contentStackView.addArrangedSubview($0) }
        
        [cancelButton, confirmButton].forEach {buttonStackView.addArrangedSubview($0)}
        
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(304)
            $0.height.equalTo(356)
        }
        
        statusBar.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(47)
        }
        
        statusBarLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        [reason1Label, reason2Label, reason3Label, reason4Label].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(49)
            }
        }
        
        [reason1Button, reason2Button, reason3Button, reason4Button].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(20)
            }
        }
        
        contentStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
            $0.top.equalTo(statusBar.snp.bottom).offset(18)
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
        cancelButton.layer.cornerRadius = 18
        confirmButton.layer.cornerRadius = 18
    }
    
}

extension ReportReasonAlertView {
    
    // reasonButton 클릭시 마다 체크마크 색 변하게
    @objc func reasonButtonTapped(sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            sender.tintColor = .BaseWarningRed
        } else {
            sender.tintColor = .gray
        }
    }
    
}
