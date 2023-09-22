//
//  Signup2View.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/21.
//

import UIKit


class Signup2View: UIView {
    
    // Add a closure property
    var certificateOfEmploymentUploadButtonActionHandler: (() -> Void)?
    var graduateCertificateUploadButtonActionHandler: (() -> Void)?
    
    private lazy var navTitleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 14)
        let text = "멘토로 회원가입"
        label.text = text
        // 멘티일 경우 파란색으로 하기
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.BaseGreen!, range: (text as NSString).range(of: "멘토"))
        label.attributedText = attributedStr
        
        return label
    }()
    
    private lazy var stepBar: SignupStepBar = {
        let bar = SignupStepBar(stepCount: 6, currentStep: 2)
        
        return bar
    }()
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        let text = "Q. 증빙서류를 업로드 해 주세요."
        label.text = text
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.BaseGreen!, range: (text as NSString).range(of: "증빙서류"))
        label.attributedText = attributedStr
        
        return label
    }()
    
    private lazy var content1Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        let text = "A. 재적증명서 업로드하기"
        
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.font, value: UIFont.nanumSquare(style: .NanumSquareOTFB, size: 20), range: (text as NSString).range(of: "재적증명서"))
        
        // Add spacing between text and underline
        let spacing: CGFloat = 2
        attributedStr.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: (text as NSString).range(of: "재적증명서"))
        attributedStr.addAttribute(.baselineOffset, value: spacing, range: (text as NSString).range(of: "재적증명서"))
        
        label.attributedText = attributedStr
        
        return label
    }()
    
    lazy var certificateOfEmploymentUploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("PDF 또는 이미지", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setBackgroundImage(UIImage(named: "FileSelectBtnImg"), for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(certificateOfEmploymentUploadButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var content2Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        let text = "A. 졸업증명서 업로드하기"
        
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.font, value: UIFont.nanumSquare(style: .NanumSquareOTFB, size: 20), range: (text as NSString).range(of: "졸업증명서"))
        
        // Add spacing between text and underline
        let spacing: CGFloat = 2
        attributedStr.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: (text as NSString).range(of: "졸업증명서"))
        attributedStr.addAttribute(.baselineOffset, value: spacing, range: (text as NSString).range(of: "졸업증명서"))
        
        label.attributedText = attributedStr
        
        return label
    }()
    
    lazy var graduateCertificateUploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("PDF 또는 이미지", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setBackgroundImage(UIImage(named: "FileSelectBtnImg"), for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(graduateCertificateUploadButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    private lazy var nextButton: BaseButton = {
        let button = BaseButton(style: .gray)
        button.setTitle("다음", for: .normal)
//        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
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
//        updateUI()
        setupSubViews()
    }

}


private extension Signup2View {
    
    func setupSubViews() {
        [navTitleLabel, stepBar, titleLabel, nextButton].forEach {addSubview($0)}
        
        [content1Label, certificateOfEmploymentUploadButton,  content2Label, graduateCertificateUploadButton].forEach {addSubview($0)}
        
        navTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalToSuperview().offset(104)
        }
        
        stepBar.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalTo(navTitleLabel.snp.bottom).offset(87)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalTo(stepBar.snp.bottom).offset(25)
        }
        
        content1Label.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(66)
        }
        
        certificateOfEmploymentUploadButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(content1Label.snp.leading)
            $0.top.equalTo(content1Label.snp.bottom).offset(18)
            $0.height.equalTo(86)
        }
        
        content2Label.snp.makeConstraints {
            $0.leading.equalTo(content1Label.snp.leading)
            $0.top.equalTo(certificateOfEmploymentUploadButton.snp.bottom).offset(58)
        }
        
        graduateCertificateUploadButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(content2Label.snp.leading)
            $0.top.equalTo(content2Label.snp.bottom).offset(18)
            $0.height.equalTo(86)
        }
        
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalTo(graduateCertificateUploadButton.snp.bottom).offset(55)
            $0.height.equalTo(45)
        }
        
        
    }
}

extension Signup2View {
    
    @objc func certificateOfEmploymentUploadButtonTapped(sender: UIButton!) {
        // Call the closure when the login button is tapped
        certificateOfEmploymentUploadButtonActionHandler?()
    }
    
    @objc func graduateCertificateUploadButtonTapped(sender: UIButton!) {
        // Call the closure when the login button is tapped
        graduateCertificateUploadButtonActionHandler?()
    }
    
}
