//
//  UserDetailProfileCardView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/07.
//

import UIKit

class UserDetailProfileCardView: UIView {
    
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
            imageView.image = UIImage(named: "MentoDetailProfileCardBackgroundImg")
        } else {
            imageView.image = UIImage(named: "MentoDetailProfileCardBackgroundImg")
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

    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        if uiStyle == .mento {
            imageView.image = UIImage(named: "MentoProfileBaseImg")
        } else {
            imageView.image = UIImage(named: "MenteeProfileBaseImg")
        }

        return imageView
    }()
    
    lazy var departmentLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.textColor = .white
        label.text = "학과"

        return label
    }()
    
    lazy var gradeLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.textColor = .white
        label.text = "n 학년"

        return label
    }()
    
    lazy var nicknameLabel: NanumLabel = {
        let label = NanumLabel(weightType: .EB, size: 30)
        label.textColor = .white
        label.text = "닉네임"
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if uiStyle == .mento {
            backgroundColor = .BaseNavy
        } else {
            backgroundColor = .BaseGreen
        }
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setup() {
        setupSubViews()
//        updateUI()
    }
    
}

private extension UserDetailProfileCardView {
    
    func setupSubViews() {
        
        [backgroundImageView, profileImageBackgroundView, departmentLabel, gradeLabel, nicknameLabel].forEach {addSubview($0)}
        
        profileImageBackgroundView.addSubview(profileImageView)
        
        backgroundImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        profileImageBackgroundView.snp.makeConstraints {
            $0.width.equalTo(126.05)
            $0.height.equalTo(138)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        profileImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageBackgroundView.snp.trailing).offset(9.95)
            $0.bottom.equalTo(profileImageBackgroundView.snp.bottom).inset(5)
        }
        
        gradeLabel.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel.snp.leading)
            $0.bottom.equalTo(nicknameLabel.snp.top).offset(-4)
        }
        
        departmentLabel.snp.makeConstraints {
            $0.leading.equalTo(gradeLabel.snp.leading)
            $0.bottom.equalTo(gradeLabel.snp.top).offset(-4)
        }
        
    }
    
}
