//
//  AccountSetView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/01.
//

import UIKit

class AccountSetView: UIView {
    
    private lazy var logoutView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    private lazy var logoutLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 17)
        label.text = "로그아웃"
        
        return label
    }()
    
    private lazy var accountResetView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    private lazy var accountResetLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 17)
        label.text = "비밀번호 재설정"
        
        return label
    }()
    
    private lazy var logoutChevronImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .black
        
        return imageView
    }()
    
    private lazy var accountResetChevronImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .black
        
        return imageView
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        
        return button
    }()
    
    lazy var accountResetButton: UIButton = {
        let button = UIButton(type: .system)
        
        return button
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

private extension AccountSetView {
    
    func setupSubViews() {
        [logoutView, accountResetView, logoutButton, accountResetButton].forEach {addSubview($0)}
        
        [logoutLabel, logoutChevronImage].forEach {logoutView.addSubview($0)}
        [accountResetLabel, accountResetChevronImage].forEach {accountResetView.addSubview($0)}
        
        logoutView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(122)
            $0.height.equalTo(79)
        }
        
        accountResetView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(logoutView.snp.leading)
            $0.top.equalTo(logoutView.snp.bottom).offset(10)
            $0.height.equalTo(79)
        }
        
        logoutLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(21)
        }
        
        logoutChevronImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-21.5)
        }
        
        accountResetLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(21)
        }
        
        accountResetChevronImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-21.5)
        }
        
        logoutButton.snp.makeConstraints {
            $0.centerX.centerY.equalTo(logoutView)
            $0.width.height.equalTo(logoutView)
        }
        
        accountResetButton.snp.makeConstraints {
            $0.centerX.centerY.equalTo(accountResetView)
            $0.width.height.equalTo(accountResetView)
        }
        
    }
    
    func updateUI() {
        
        // View에 그림자와 cornerRadius 적용
        [logoutView, accountResetView].forEach { view in
            view.layer.cornerRadius = 20
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 0.2
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.shadowRadius = 7
            view.layer.masksToBounds = false
        }
        
    }
    
}
