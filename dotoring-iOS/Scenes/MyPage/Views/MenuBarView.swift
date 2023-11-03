//
//  MenuBarView.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/3/23.
//

import UIKit

/**
 * 마이페이지 하단에서 차단 관리, 작성글 관리, 멘토링 방식, 계정 설정 버튼을 포함하고 있는 메뉴바 입니다.
 * 하나의 가로 스택뷰에 4개의 버튼이 포함 되어 있습니다.
 */
class MenuBarView: UIView {
    
    private lazy var menuBarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private lazy var blockMnageButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "차단 관리"
        config.image = UIImage(named: "MyPageMenuBarBlockManageBtnImg")
        config.imagePlacement = .top
        config.imagePadding = 8
        
        // 텍스트 속성을 정의합니다. 원하는 폰트와 스타일을 적용합니다.
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.nanumSquare(style: .NanumSquareOTFB, size: 13),
            .foregroundColor: UIColor.BaseGray900!
        ]
        
        let attributedTitle = NSAttributedString(string: "차단 관리", attributes: titleAttributes)
        
        let button = UIButton(configuration: config)
        button.tintColor = .BaseGray900
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }()
    
    private lazy var postManageButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "작성글 관리"
        config.image = UIImage(named: "MyPageMenuBarPostMangeBtnImg")
        config.imagePlacement = .top
        config.imagePadding = 8
        
        // 텍스트 속성을 정의합니다. 원하는 폰트와 스타일을 적용합니다.
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.nanumSquare(style: .NanumSquareOTFB, size: 13),
            .foregroundColor: UIColor.BaseGray900!
        ]
        
        let attributedTitle = NSAttributedString(string: "작성글 관리", attributes: titleAttributes)
        
        let button = UIButton(configuration: config)
        button.tintColor = .BaseGray900
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }()
    
    private lazy var mentorignTypeButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "멘토링 방식"
        config.image = UIImage(named: "MyPageMenuBarMentoringTypeBtnImg")
        config.imagePlacement = .top
        config.imagePadding = 8
        
        // 텍스트 속성을 정의합니다. 원하는 폰트와 스타일을 적용합니다.
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.nanumSquare(style: .NanumSquareOTFB, size: 13),
            .foregroundColor: UIColor.BaseGray900!
        ]
        
        let attributedTitle = NSAttributedString(string: "멘토링 방식", attributes: titleAttributes)
        
        let button = UIButton(configuration: config)
        button.tintColor = .BaseGray900
        button.setAttributedTitle(attributedTitle, for: .normal)
     
        
        return button
    }()
    
    private lazy var accountSetButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "계정 설정"
        config.image = UIImage(named: "MyPageMenuBarAccountSetBtnImg")
        config.imagePlacement = .top
        config.imagePadding = 8
        
        // 텍스트 속성을 정의합니다. 원하는 폰트와 스타일을 적용합니다.
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.nanumSquare(style: .NanumSquareOTFB, size: 13),
            .foregroundColor: UIColor.BaseGray900!
        ]
        
        let attributedTitle = NSAttributedString(string: "계정 설정", attributes: titleAttributes)
        
        let button = UIButton(configuration: config)
        button.tintColor = .BaseGray900
        button.setAttributedTitle(attributedTitle, for: .normal)
        
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
    }
    
}

private extension MenuBarView {
    
    func setupSubViews() {
        
        [menuBarStackView].forEach { addSubview($0)
        }
        
        [blockMnageButton, postManageButton, mentorignTypeButton, accountSetButton].forEach { menuBarStackView.addArrangedSubview($0)
        }
        
        menuBarStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.top.equalToSuperview().offset(25)
        }
        
    }

}
