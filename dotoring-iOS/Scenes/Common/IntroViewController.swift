//
//  IntroViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/31.
//

import SnapKit
import UIKit

class IntroViewController: UIViewController {
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 28)
        label.textColor = .BaseGray900
        let text = "우리들의 멘토링\n도토링"
        label.text = text
        label.numberOfLines = 2
        
        let fontSize = UIFont.nanumSquare(style: .NanumSquareOTFEB, size: 34)
        let attributedStr = NSMutableAttributedString(string: text)

        attributedStr.addAttribute(.font, value: fontSize, range: (text as NSString).range(of: "도토링"))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 7 // 행간 조절
        paragraphStyle.alignment = .center // 가운데 정렬
        attributedStr.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedStr.length))
        
        label.attributedText = attributedStr
        
        
        return label
    }()
    
    private lazy var mainLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "GreenDotoriLogoImg")
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)

        return imageView
    }()
    
    private lazy var mentoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .BaseGreen
        button.layer.cornerRadius = 17
        button.addTarget(self, action: #selector(mentoButtonTapped), for: .touchUpInside)

        return button
    }()
    
    private lazy var mentiButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .BaseNavy
        button.layer.cornerRadius = 17
        button.addTarget(self, action: #selector(menteeButtonTapped), for: .touchUpInside)

        return button
    }()
    
    private lazy var mentoBtnLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 17)
        label.textColor = .white
        let text = "후배들에게 도움을 주는\n멘토"
        label.text = text
        label.numberOfLines = 2
        
        let fontSize = UIFont.nanumSquare(style: .NanumSquareOTFEB, size: 20)
        let attributedStr = NSMutableAttributedString(string: text)

        attributedStr.addAttribute(.font, value: fontSize, range: (text as NSString).range(of: "멘토"))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 9 // 행간 조절
        paragraphStyle.alignment = .center // 가운데 정렬
        attributedStr.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedStr.length))
        
        label.attributedText = attributedStr
        
        
        return label
    }()
    
    private lazy var mentiBtnLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 17)
        label.textColor = .white
        let text = "더 성장하고 싶은\n멘티"
        label.text = text
        label.numberOfLines = 2
        
        let fontSize = UIFont.nanumSquare(style: .NanumSquareOTFEB, size: 20)
        let attributedStr = NSMutableAttributedString(string: text)

        attributedStr.addAttribute(.font, value: fontSize, range: (text as NSString).range(of: "멘티"))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 9 // 행간 조절
        paragraphStyle.alignment = .center // 가운데 정렬
        attributedStr.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedStr.length))
        
        label.attributedText = attributedStr
        
        
        return label
    }()
    
    private lazy var goLoginButton: UIButton = {
        let button = UIButton()
        let title = "로그인하러 가기"
        button.addTarget(self, action: #selector(goLoginButtonTapped), for: .touchUpInside)
        
        let attributedTitle = NSMutableAttributedString(string: title)
        attributedTitle.addAttribute(.foregroundColor, value: UIColor.BaseGray600!, range: NSRange(location: 0, length: attributedTitle.length))
        attributedTitle.addAttribute(.font, value: UIFont.nanumSquare(style: .NanumSquareOTFR, size: 13), range: NSRange(location: 0, length: attributedTitle.length))
        
        // 텍스트와 밑줄 사이에 간격 추가
        let spacing: CGFloat = 2
        attributedTitle.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedTitle.length))
        attributedTitle.addAttribute(.baselineOffset, value: spacing, range: NSRange(location: 0, length: attributedTitle.length))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setContentCompressionResistancePriority(.required, for: .vertical)
        
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        setup()
    }
    
    func setup() {
        setupSubViews()
    }
}

private extension IntroViewController {
    
    func setupSubViews() {
        
        [titleLabel, mainLogoImageView, mentoButton, mentiButton, mentoBtnLabel, mentiBtnLabel, goLoginButton].forEach { view.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(151).priority(.low)
            $0.top.greaterThanOrEqualToSuperview().inset(50).priority(.high)
        }
        
        mainLogoImageView.snp.makeConstraints {
            $0.centerX.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(38)
        }
        
        mentoButton.snp.makeConstraints {
            $0.centerX.equalTo(mainLogoImageView)
            $0.leading.equalToSuperview().offset(52)
            $0.top.equalTo(mainLogoImageView.snp.bottom).offset(38.66)
            $0.height.equalTo(103.0).priority(251)
            $0.height.greaterThanOrEqualTo(80.0).priority(.high)
        }
        
        mentiButton.snp.makeConstraints {
            $0.centerX.equalTo(mentoButton)
            $0.leading.equalTo(mentoButton.snp.leading)
            $0.top.equalTo(mentoButton.snp.bottom).offset(12)
            $0.height.equalTo(103.0).priority(251)
            $0.height.greaterThanOrEqualTo(80.0).priority(.high)
            $0.bottom.equalTo(goLoginButton.snp.top).offset(-100).priority(751)
            $0.bottom.greaterThanOrEqualTo(goLoginButton.snp.top).offset(-10).priority(751)
        }
        
        mentoBtnLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(mentoButton)
        }
        
        mentiBtnLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(mentiButton)
        }
        
        goLoginButton.snp.makeConstraints {
            $0.centerX.equalTo(mentiButton)
            $0.bottom.equalToSuperview().inset(58).priority(.high)
            $0.bottom.greaterThanOrEqualToSuperview().inset(10).priority(.high)
        }
        
    }
}

extension IntroViewController {
 
    @objc func goLoginButtonTapped(sender: UIButton!) {
        if let viewControllers = self.navigationController?.viewControllers, viewControllers.count >= 2 {
            let destinationVC = viewControllers[viewControllers.count - 2]
            self.navigationController?.popToViewController(destinationVC, animated: true)
        }
    }
    
    @objc func mentoButtonTapped(sender: UIButton!) {
        UserDefaults.standard.set("mento", forKey: "UIStyle")
        let vc = MentoSignup1ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func menteeButtonTapped(sender: UIButton!) {
        UserDefaults.standard.set("mentee", forKey: "UIStyle")
        let vc = MenteeSignup1ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
