//
//  UserDetailView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/07.
//

import UIKit

class UserDetailView: UIView {
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var userDetailProfileCardView: UserDetailProfileCardView = {
        let userDetailProfileCardView = UserDetailProfileCardView(frame: frame)
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
    
    lazy var fieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 13
        return stackView
    }()
    
    private lazy var fieldScrollerView: UIScrollView = {
        let scrollerView = UIScrollView()
        scrollerView.translatesAutoresizingMaskIntoConstraints = false
        scrollerView.showsHorizontalScrollIndicator = false
        scrollerView.addSubview(fieldStackView)
        return scrollerView
    }()
    
    private lazy var hopeFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        [hopeFieldLabel, fieldScrollerView].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var introductionLabel: NanumLabel = {
        let label = NanumLabel(weightType: .EB, size: 20)
        label.text = "한 줄 소개"
        
        return label
    }()
    
    lazy var introductionContentLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 17)
        label.text = "내용"
        label.numberOfLines = 0
        label.textAlignment = .natural
        
        return label
    }()
    
    private lazy var introductionStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        [introductionLabel, introductionContentLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var hopeMentoringLabel: NanumLabel = {
        let label = NanumLabel(weightType: .EB, size: 20)
        label.text = "원하는 멘토링"
        
        return label
    }()
    
    lazy var hopeMentoringContentLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 17)
        label.text = "내용"
        label.numberOfLines = 0
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var hopeMentoringStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        [hopeMentoringLabel, hopeMentoringContentLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var middleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
       
        [hopeFieldStackView, introductionStackView, hopeMentoringStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        let spaceView1 = UIView()
        let spaceView2 = UIView()
        spaceView2.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        [spaceView1, middleStackView, spaceView2].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    private lazy var chatButton: UIButton = {
        let button = UIButton(type: .system)
        
        if uiStyle == .mento {
            button.backgroundColor = .BaseNavy
        } else {
            button.backgroundColor = .BaseGreen
        }
        
        button.setImage(UIImage(named: "UserDetailViewChatBtnImg"), for: .normal)
        button.tintColor = .white
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }
    
    func setup() {
        setupSubViews()
    }
    
}

private extension UserDetailView {
    
    func setupSubViews() {
        
        [userDetailProfileCardShadowView, userDetailProfileCardView, chatButton, scrollView].forEach{addSubview($0)}
        scrollView.addSubview(mainStackView)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(userDetailProfileCardView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        mainStackView.snp.makeConstraints {
           $0.edges.width.equalToSuperview()
        }
        
        fieldStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        userDetailProfileCardView.snp.makeConstraints {
            // iphone SE에서만 오류뜸
            // safeLayoutGuide로 안 해서 오류뜨긴 하는데 작동은함..
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(frame.height * 0.34)
        }
        
        userDetailProfileCardShadowView.snp.makeConstraints {
            $0.edges.equalTo(userDetailProfileCardView)
        }
        
        chatButton.snp.makeConstraints {
            $0.width.height.equalTo(61)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
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
        
        [chatButton].forEach { view in
            view.layer.cornerRadius = view.frame.height/2
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 0.3
            view.layer.shadowOffset = CGSize(width: 0, height: 3)
            view.layer.shadowRadius = 5
        }
        
    }
    
}
