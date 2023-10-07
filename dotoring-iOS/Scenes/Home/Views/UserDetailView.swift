//
//  UserDetailView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/07.
//

import UIKit

class UserDetailView: UIView {
    
    private lazy var userDetailProfileCardView: UserDetailProfileCardView = {
        let userDetailProfileCardView = UserDetailProfileCardView()
        
        return userDetailProfileCardView
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

private extension UserDetailView {
    
    func setupSubViews() {
        
        [userDetailProfileCardView].forEach{addSubview($0)}
        
        userDetailProfileCardView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(289)
            $0.top.equalToSuperview()
        }
        
    }
    
    func updateUI() {
        // View에 그림자와 cornerRadius 적용
        [userDetailProfileCardView].forEach { view in
            view.layer.cornerRadius = 20
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 0.4
            view.layer.shadowOffset = CGSize(width: 0, height: 4)
            view.layer.shadowRadius = 8
            view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            view.layer.masksToBounds = false
        }
    }
    
}
