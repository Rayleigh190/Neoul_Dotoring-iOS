//
//  ProfileCardView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/30.
//

import UIKit

class ProfileCardView: UIView {
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        if uiStyle == .mento {
            imageView.image = UIImage(named: "MentoProfileCardBackgroundImg")
        } else {
            imageView.image = UIImage(named: "MenteeProfileCardBackgroundImg")
        }
        

        return imageView
    }()
    
    private lazy var profileImageBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
        view.clipsToBounds = true
        view.layer.cornerRadius = 20.0
       
        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        if uiStyle == .mento {
            imageView.image = UIImage(named: "MenteeProfileBaseImg")
        } else {
            imageView.image = UIImage(named: "MentoProfileBaseImg")
        }

        return imageView
    }()
    
    private lazy var nickNameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("닉네임", for: .normal)
        
        if uiStyle == .mento {
            button.setTitleColor(.BaseGreen, for: .normal)
        } else {
            button.setTitleColor(.BaseNavy, for: .normal)
        }
        
        button.titleLabel?.font = UIFont.nanumSquare(style: .NanumSquareOTFB, size: 20)
        
        // Create a custom button configuration
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        // Apply the custom configuration to the button
        button.configuration = buttonConfiguration
        
        return button
    }()
    
    private lazy var departmentButton: UIButton = {
        let button = UIButton(type: .system)
        
        if uiStyle == .mento {
            button.setTitle("소속", for: .normal)
        } else {
            button.setTitle("학과", for: .normal)
        }
        
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 13)
        
        // Create a custom button configuration
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        // Apply the custom configuration to the button
        button.configuration = buttonConfiguration
        
        return button
    }()
    
    private lazy var jobButton: UIButton = {
        let button = UIButton(type: .system)
        
        if uiStyle == .mento {
            button.setTitle("직무 분야", for: .normal)
        } else {
            button.setTitle("희망 직무 분야", for: .normal)
        }
        
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 13)
        
        // Create a custom button configuration
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        // Apply the custom configuration to the button
        button.configuration = buttonConfiguration
        
        return button
    }()
    
    private lazy var gradeButton: UIButton = {
        let button = UIButton(type: .system)
        
        if uiStyle == .mento {
            button.setTitle("n년차", for: .normal)
        } else {
            button.setTitle("n학년", for: .normal)
        }
        
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 13)
        
        // Create a custom button configuration
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        // Apply the custom configuration to the button
        button.configuration = buttonConfiguration
        
        return button
    }()
    
    private lazy var graduationDepartmentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("졸업학과", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 13)
        
        // Create a custom button configuration
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        // Apply the custom configuration to the button
        button.configuration = buttonConfiguration
        
        return button
    }()
    
    private lazy var introductionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "한 줄 소개"
        textView.backgroundColor = .clear
        textView.font = UIFont.nanumSquare(style: .NanumSquareOTFR, size: 10)
        textView.isScrollEnabled = false
        textView.isEditable = false
        
        return textView
    }()
    
    private lazy var introductionEditButton: UIButton = {
        let button = UIButton(type: .system)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
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

private extension ProfileCardView {
    
    func setupSubViews() {
        [backgroundImageView, profileImageBackgroundView, nickNameButton, departmentButton, jobButton, gradeButton, graduationDepartmentButton, introductionTextView, introductionEditButton]
            .forEach { addSubview($0) }
        
        profileImageBackgroundView.addSubview(profileImageView)
        
        backgroundImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        profileImageBackgroundView.snp.makeConstraints {
            $0.width.equalTo(94)
            $0.height.equalTo(103)
            $0.leading.equalToSuperview().offset(26)
            $0.top.equalToSuperview().offset(26)
        }
        
        profileImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        nickNameButton.snp.makeConstraints {
            $0.leading.equalTo(profileImageBackgroundView.snp.trailing).offset(14)
            $0.top.equalTo(profileImageBackgroundView.snp.top).offset(5)
        }
        
        departmentButton.snp.makeConstraints {
            $0.leading.equalTo(nickNameButton.snp.leading)
            $0.top.equalTo(nickNameButton.snp.bottom).offset(6)
        }
        
        jobButton.snp.makeConstraints {
            $0.leading.equalTo(departmentButton.snp.leading)
            $0.top.equalTo(departmentButton.snp.bottom).offset(6)
        }
        
        gradeButton.snp.makeConstraints {
            $0.leading.equalTo(jobButton.snp.leading)
            $0.top.equalTo(jobButton.snp.bottom).offset(6)
        }
        
        graduationDepartmentButton.snp.makeConstraints {
            $0.centerY.equalTo(gradeButton)
            $0.leading.equalTo(gradeButton.snp.trailing).offset(34)
        }
        
        introductionTextView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(profileImageBackgroundView.snp.leading).offset(8)
            $0.top.equalTo(profileImageBackgroundView.snp.bottom).offset(11)
        }
        
        introductionEditButton.snp.makeConstraints {
            $0.centerX.centerY.equalTo(introductionTextView)
            $0.width.height.equalTo(introductionTextView)
        }
    }
    
    func updateUI() {
        if uiStyle == .mentee {
            graduationDepartmentButton.isHidden = true
        }
    }
}
