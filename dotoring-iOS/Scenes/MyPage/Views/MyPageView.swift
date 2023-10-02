//
//  MyPageView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/30.
//

import UIKit

final class MyPageView: UIView {
    
    // Add a closure property
    var setMentoringButtonActionHandler: (() -> Void)?
    var setAccountButtonActionHandler: (() -> Void)?
    var departmentButtonActionHandler: (() -> Void)?
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 30)
        label.text = "마이페이지"
        label.textColor = .label
        
        return label
    }()
    
    private lazy var profileCardView: ProfileCardView = {
        let view = ProfileCardView()
        view.backgroundColor = .systemBackground
        view.departmentButton.addTarget(self, action: #selector(departmentButtonTapped), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var infoLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 10)
        label.text = "수정을 원하시면 해당 텍스트를 클릭해 주세요."
        label.textColor = .BaseSecondaryEmhasisGray
        
        return label
    }()
    
    private lazy var setStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        
        return stackView
    }()
    
    private lazy var setMentorignView: SetMenuView = {
        let view = SetMenuView(frame: self.frame, title: "멘토링 방식 설정하기", image: UIImage(named: "MentoringSetMenuLogoImg")!)        
        
        return view
    }()
    
    private lazy var setAccountView: UIView = {
        let view = SetMenuView(frame: self.frame, title: "계정 설정하기", image: UIImage(named: "AccountSetMenuLogoImg")!)
        
        return view
    }()
    
    private lazy var setMentoringButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(setMentorignButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var setAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(setAccountButtonTapped), for: .touchUpInside)
        
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

private extension MyPageView {
    
    func setupSubViews() {
        [titleLabel, profileCardView, infoLabel, setStackView, setMentoringButton, setAccountButton].forEach {addSubview($0)}
        
        [setMentorignView, setAccountView].forEach {setStackView.addArrangedSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalToSuperview().offset(77)
        }
        
        profileCardView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalTo(titleLabel.snp.bottom).offset(39)
            $0.height.equalTo(220)
        }
        
        infoLabel.snp.makeConstraints {
            $0.centerX.equalTo(profileCardView)
            $0.top.equalTo(profileCardView.snp.bottom).offset(10)
        }
        
        setStackView.snp.makeConstraints {
            $0.centerX.equalTo(profileCardView)
            $0.leading.equalTo(profileCardView.snp.leading)
            $0.top.equalTo(profileCardView.snp.bottom).offset(39)
        }
        
        setMentorignView.snp.makeConstraints {
            $0.height.equalTo(154)
        }
        
        setAccountView.snp.makeConstraints {
            $0.height.equalTo(154)
        }
        
        setMentoringButton.snp.makeConstraints {
            $0.centerX.centerY.equalTo(setMentorignView)
            $0.width.height.equalTo(setMentorignView)
        }
        
        setAccountButton.snp.makeConstraints {
            $0.centerX.centerY.equalTo(setAccountView)
            $0.width.height.equalTo(setAccountView)
        }
        
    }
    
    func updateUI() {
        // View에 그림자와 cornerRadius 적용
        [profileCardView, setMentorignView, setAccountView].forEach { view in
            view.layer.cornerRadius = 20
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 0.2
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.shadowRadius = 7
            view.layer.masksToBounds = false
        }
    
        
    }
    
}

extension MyPageView {
    
    @objc func setMentorignButtonTapped(sender: UIButton!) {
        // Call the closure when the login button is tapped
        setMentoringButtonActionHandler?()
    }
    
    @objc func setAccountButtonTapped(sender: UIButton!) {
        // Call the closure when the login button is tapped
        setAccountButtonActionHandler?()
    }
    
    @objc func departmentButtonTapped(sender: UIButton!) {
        // Call the closure when the login button is tapped
        departmentButtonActionHandler?()
    }
    
}
