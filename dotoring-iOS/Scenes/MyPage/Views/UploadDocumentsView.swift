//
//  UploadDocumentsView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/02.
//

import UIKit

class UploadDocumentsView: UIView {
    
    // Add a closure property
    var         groupCertificateUploadButtonActionHandler: (() -> Void)?
    var graduateCertificateUploadButtonActionHandler: (() -> Void)?
    var nextButtonActionHandler: (() -> Void)?
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 28)
        label.numberOfLines = 0
        var text = "수정된 직무에 맞는\n서류를 업로드해 주세요."
        var attrRangeText = "서류"
        var attrStrColor = UIColor.label
        
        if uiStyle == .mento {
            attrStrColor = .BaseGreen!
        } else {
            attrStrColor = .BaseNavy!
        }
        
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.font, value: UIFont.nanumSquare(style: .NanumSquareOTFB, size: 28), range: (text as NSString).range(of: attrRangeText))
        attributedStr.addAttribute(.foregroundColor, value: attrStrColor, range: (text as NSString).range(of: attrRangeText))
        
        label.attributedText = attributedStr
        
        return label
    }()
    
    private lazy var content1Label: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        var text = ""
        var attrRangeText = ""
        var attrStrColor = UIColor.label
        
        if uiStyle == .mento {
            text = "A. 재적증명서 업로드하기"
            attrRangeText = "재적증명서"
            attrStrColor = .BaseGreen!
        } else {
            text = "A. 재학증명서 업로드하기"
            attrRangeText = "재학증명서"
            attrStrColor = .BaseNavy!
        }
        
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.font, value: UIFont.nanumSquare(style: .NanumSquareOTFB, size: 20), range: (text as NSString).range(of: attrRangeText))
        
        // Add spacing between text and underline
        let spacing: CGFloat = 2
        attributedStr.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: (text as NSString).range(of: attrRangeText))
        attributedStr.addAttribute(.baselineOffset, value: spacing, range: (text as NSString).range(of: attrRangeText))
        
        label.attributedText = attributedStr
        
        return label
    }()
    
    lazy var groupCertificateUploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("PDF 또는 이미지", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setBackgroundImage(UIImage(named: "FileSelectBtnImg"), for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(groupCertificateUploadButtonTapped), for: .touchUpInside)
        
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
    
    private lazy var saveButton: BaseButton = {
//        let button: BaseButton = {
//            if uiStyle == .mento {
//                return BaseButton(style: .green)
//            } else {
//                return BaseButton(style: .navy)
//            }
//        }()
        let button = BaseButton(style: .gray)
        button.setTitle("완료", for: .normal)
//        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var cancelButton: BaseButton = {
        let button = BaseButton(style: .gray)
        button.setTitle("수정 취소", for: .normal)
//        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
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

private extension UploadDocumentsView {
    
    func setupSubViews() {
        [titleLabel, saveButton, cancelButton].forEach {addSubview($0)}
        
        [content1Label, groupCertificateUploadButton,  content2Label, graduateCertificateUploadButton].forEach {addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(178)
        }
        
        content1Label.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
        }
        
        groupCertificateUploadButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(content1Label.snp.leading)
            $0.top.equalTo(content1Label.snp.bottom).offset(18)
            $0.height.equalTo(86)
        }
        
        if uiStyle == .mento {
            content2Label.snp.makeConstraints {
                $0.leading.equalTo(content1Label.snp.leading)
                $0.top.equalTo(groupCertificateUploadButton.snp.bottom).offset(58)
            }
            
            graduateCertificateUploadButton.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.leading.equalTo(content2Label.snp.leading)
                $0.top.equalTo(content2Label.snp.bottom).offset(18)
                $0.height.equalTo(86)
            }
            
        } else {
            // 멘티 회원가입에서는 안 보이게 함
            content2Label.snp.makeConstraints {
                $0.leading.equalTo(content1Label.snp.leading)
                $0.top.equalTo(groupCertificateUploadButton.snp.bottom).offset(0)
                $0.height.equalTo(0)
            }
            
            graduateCertificateUploadButton.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.leading.equalTo(content2Label.snp.leading)
                $0.top.equalTo(content2Label.snp.bottom).offset(0)
                $0.height.equalTo(0)
            }
            graduateCertificateUploadButton.isHidden = true
        }
        
        cancelButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(94)
            $0.height.equalTo(48)
        }
        
        saveButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalTo(cancelButton.snp.top).offset(-5)
            $0.height.equalTo(48)
        }
        
    }
}

extension UploadDocumentsView {
    
    @objc func groupCertificateUploadButtonTapped(sender: UIButton!) {
        // Call the closure when the login button is tapped
                groupCertificateUploadButtonActionHandler?()
    }
    
    @objc func graduateCertificateUploadButtonTapped(sender: UIButton!) {
        // Call the closure when the login button is tapped
        graduateCertificateUploadButtonActionHandler?()
    }
    
}
