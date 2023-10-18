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
    
    private lazy var userDetailProfileCardShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    private lazy var hopeFieldLabel: NanumLabel = {
        let label = NanumLabel(weightType: .EB, size: 20)
        label.text = "희망 멘토링 분야"
        
        return label
    }()
    
    private lazy var scrollerView: UIScrollView = {
        let scrollerView = UIScrollView()
        scrollerView.translatesAutoresizingMaskIntoConstraints = false
        scrollerView.showsHorizontalScrollIndicator = false
        
        return scrollerView
    }()
    
    lazy var fieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 13
        
        return stackView
    }()
    
    private lazy var introductionLabel: NanumLabel = {
        let label = NanumLabel(weightType: .EB, size: 20)
        label.text = "한 줄 소개"
        
        return label
    }()
    
    private lazy var introductionContentLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 17)
        label.text = "내용"
        label.numberOfLines = 0
        label.textAlignment = .natural
        
        return label
    }()
    
    private lazy var hopeMentoringLabel: NanumLabel = {
        let label = NanumLabel(weightType: .EB, size: 20)
        label.text = "원하는 멘토링"
        
        return label
    }()
    
    private lazy var hopeMentoringContentLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 17)
        label.text = "내용"
        label.numberOfLines = 0
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var chatButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .BaseNavy
        button.setTitle("채팅", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
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

private extension UserDetailView {
    
    func setupSubViews() {
        
        [userDetailProfileCardShadowView, userDetailProfileCardView, hopeFieldLabel, scrollerView, introductionLabel, introductionContentLabel, hopeMentoringLabel, hopeMentoringContentLabel, chatButton].forEach{addSubview($0)}
        
        scrollerView.addSubview(fieldStackView)
        
        userDetailProfileCardView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(289)
            $0.top.equalToSuperview()
        }
        
        userDetailProfileCardShadowView.snp.makeConstraints {
            $0.edges.equalTo(userDetailProfileCardView)
        }
        
        hopeFieldLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(userDetailProfileCardView.snp.bottom).offset(30)
        }
        
        scrollerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.top.equalTo(hopeFieldLabel.snp.bottom).offset(10)
        }
        
        fieldStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.bottom.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        introductionLabel.snp.makeConstraints {
            $0.leading.equalTo(hopeFieldLabel.snp.leading)
            $0.top.equalTo(hopeFieldLabel.snp.bottom).offset(98)
        }
        
        introductionContentLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(introductionLabel.snp.leading)
            $0.top.equalTo(introductionLabel.snp.bottom).offset(5)
        }
        
        hopeMentoringLabel.snp.makeConstraints {
            $0.leading.equalTo(introductionContentLabel.snp.leading)
            $0.top.equalTo(introductionContentLabel.snp.bottom).offset(40)
        }
        
        hopeMentoringContentLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(hopeMentoringLabel.snp.leading)
            $0.top.equalTo(hopeMentoringLabel.snp.bottom).offset(5)
        }
        
        chatButton.snp.makeConstraints {
            $0.width.height.equalTo(61)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-32)
        }
        
    }
    
    func updateUI() {
        // View에 그림자와 cornerRadius 적용
        [userDetailProfileCardView].forEach { view in
            view.layer.cornerRadius = 20
            view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            view.clipsToBounds = true
        }
        
        [userDetailProfileCardShadowView].forEach { view in
            view.layer.cornerRadius = 20
            view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            view.layer.shadowColor = UIColor.black.withAlphaComponent(0.36).cgColor
            view.layer.shadowOpacity = 1
            view.layer.shadowOffset = CGSize(width: 0, height: 4)
            view.layer.shadowRadius = 8
        }
    }
    
}
