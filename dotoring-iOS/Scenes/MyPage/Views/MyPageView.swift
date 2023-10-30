//
//  MyPageView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/30.
//

import UIKit

final class MyPageView: UIView {
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .EB, size: 34)
        label.text = "마이페이지"
        label.textColor = .BaseGray900
        
        return label
    }()
    
    private lazy var profileCardView: ProfileCardView = {
        let view = ProfileCardView()
        view.layer.cornerRadius = 20
        
        if uiStyle == .mento {
            view.backgroundColor = .BaseGreen
        } else {
            view.backgroundColor = .BaseNavy
        }
        
        return view
    }()
    
    private lazy var organizationLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 15)
        label.textColor = .BaseGray600
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        if uiStyle == .mento {
            label.text = "소속 |"
        } else {
            label.text = "학교 |"
        }
        
        return label
    }()
    
    private lazy var userOrganizationLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.textColor = .BaseGray900
        label.text = "소속 or 학교"
        
        return label
    }()
    
    private lazy var organizationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        
        [organizationLabel, userOrganizationLabel].forEach {stackView.addArrangedSubview($0)}
        
        return stackView
    }()
    
    private lazy var dashedLine1ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DashedLineImg")
        
        return imageView
    }()
    
    private lazy var fieldLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 15)
        label.textColor = .BaseGray600
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        if uiStyle == .mento {
            label.text = "분야 |"
        } else {
            label.text = "학과 |"
        }
        
        return label
    }()
    
    private lazy var userFieldLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.textColor = .BaseGray900
        label.text = "멘토링 분야 or -학과"
        
        return label
    }()
    
    private lazy var fieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        
        [fieldLabel, userFieldLabel].forEach {stackView.addArrangedSubview($0)}
        
        return stackView
    }()
    
    private lazy var dashedLine2ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DashedLineImg")
        
        return imageView
    }()
    
    private lazy var gradeLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 15)
        label.textColor = .BaseGray600
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        if uiStyle == .mento {
            label.text = "연차 |"
        } else {
            label.text = "학년 |"
        }
        
        return label
    }()
    
    private lazy var userGradeLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.textColor = .BaseGray900
        label.text = "n년차 or n학년"
        
        return label
    }()
    
    private lazy var gradeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        
        [gradeLabel, userGradeLabel].forEach {stackView.addArrangedSubview($0)}
        
        return stackView
    }()
    
    private lazy var dashedLine3ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DashedLineImg")
        
        return imageView
    }()
    
    private lazy var field2Label: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 15)
        label.textColor = .BaseGray600
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        if uiStyle == .mento {
            label.text = "학과 |"
        } else {
            label.text = "분야 |"
        }
        
        return label
    }()
    
    private lazy var userfield2Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.textColor = .BaseGray900
        label.text = "x학과 졸업 or 희망 직무 분야"
        
        return label
    }()
    
    private lazy var field2StackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        
        [field2Label, userfield2Label].forEach {stackView.addArrangedSubview($0)}
        
        return stackView
    }()
    
    private lazy var dashedLine4ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DashedLineImg")
        
        return imageView
    }()
    
    private lazy var userInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 21
        
        [organizationStackView, dashedLine1ImageView,
         fieldStackView, dashedLine2ImageView,
         gradeStackView, dashedLine3ImageView,
         field2StackView, dashedLine4ImageView].forEach { stackView.addArrangedSubview($0) }
        
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
        updateUI()
    }
    
}

private extension MyPageView {
    
    func setupSubViews() {
        [titleLabel, profileCardView, userInfoStackView].forEach {addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalToSuperview().offset(59)
        }
        
        profileCardView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.height.equalTo(121)
        }
        
        userInfoStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(profileCardView.snp.bottom).offset(24)
        }
        
    }
    
    func updateUI() {
        backgroundColor = .BaseGray100
    }
    
}

extension MyPageView {
    

    
}
