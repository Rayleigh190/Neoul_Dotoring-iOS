//
//  FindIdCheckView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/29.
//

import UIKit

class FindIdCheckView: UIView {
    
    var goLoginButtonActionHandler: (() -> Void)?
    
    private lazy var firstLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.textColor = .label
        label.text = "회원님의 아이디는"
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var idLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 15)
        label.textColor = .label
        label.text = "아이디"
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var secondLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.textColor = .label
        label.text = "입니다."
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var idBoxView: UIView = {
        let view = UIView()
        view.backgroundColor = .BaseGray200
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    private lazy var goLoginButton: BaseButton = {
        let button = BaseButton(style: .black)
        button.setTitle("로그인하러 가기", for: .normal)
        button.addTarget(self, action: #selector(goLoginButtonTapped), for: .touchUpInside)
        
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
    }

}

private extension FindIdCheckView {
    
    func setupSubViews() {
        
        [firstLabel, secondLabel, idBoxView, goLoginButton].forEach { addSubview($0)}
        
        idBoxView.addSubview(idLabel)
        
        firstLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(35.0)
            $0.top.equalToSuperview().inset(238.0)
        }
        
        idBoxView.snp.makeConstraints {
            $0.height.equalTo(103.0)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(firstLabel.snp.leading)
            $0.top.equalTo(firstLabel.snp.bottom).offset(15.0)
        }
        
        idLabel.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
        
        secondLabel.snp.makeConstraints {
            $0.trailing.equalTo(idBoxView.snp.trailing)
            $0.top.equalTo(idBoxView.snp.bottom).offset(15.0)
        }
        
        goLoginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(35.0)
            $0.top.equalTo(secondLabel).offset(55.0)
            $0.height.equalTo(48.0)
        }
        
    }
}

extension FindIdCheckView {
    
    @objc func goLoginButtonTapped(sender: UIButton!) {
        // Call the closure when the login button is tapped
        goLoginButtonActionHandler?()
    }
    
}
