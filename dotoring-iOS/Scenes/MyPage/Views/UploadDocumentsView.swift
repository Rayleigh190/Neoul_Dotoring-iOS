//
//  UploadDocumentsView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/02.
//

import UIKit

/**
 * 마이페이지 > 계정 설정 > 정보 수정하기(버튼) > 정보 수정 > 서류 제출
 * 계정 정보 수정 후 서류를 제출하는 View입니다.
 */
class UploadDocumentsView: UIView {
    // 뷰 전체 높이 길이
    let screenHeight = UIScreen.main.bounds.size.height
    var certificateUploadButtonActionHandler: (() -> Void)?
    
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
        var text = "수정된 내용에 맞는\n서류를 업로드해 주세요."
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
        var text = "A. 재학증명서 업로드하기"
        var attrRangeText = "재학증명서"
        
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.font, value: UIFont.nanumSquare(style: .NanumSquareOTFB, size: 20), range: (text as NSString).range(of: attrRangeText))
        
        let spacing: CGFloat = 2
        attributedStr.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: (text as NSString).range(of: attrRangeText))
        attributedStr.addAttribute(.baselineOffset, value: spacing, range: (text as NSString).range(of: attrRangeText))
        
        label.attributedText = attributedStr
        
        return label
    }()
    
    lazy var certificateUploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("PDF 또는 이미지", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setBackgroundImage(UIImage(named: "FileSelectBtnImg"), for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(certificateUploadButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var saveButton: BaseButton = {
        let button = BaseButton(style: .gray)
        button.setTitle("완료", for: .normal)
        return button
    }()
    
    lazy var cancelButton: BaseButton = {
        let button = BaseButton(style: .gray)
        button.setTitle("수정 취소", for: .normal)
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
        
        [content1Label, certificateUploadButton].forEach {addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            if screenHeight <= 568 {
                $0.top.equalToSuperview().inset(70)
            } else {
                $0.top.equalToSuperview().offset(178).priority(.low)
                $0.top.greaterThanOrEqualToSuperview().inset(30).priority(.required)
            }
        }
        
        content1Label.snp.makeConstraints {
            $0.leading.trailing.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
        }
        
        certificateUploadButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(content1Label.snp.leading)
            $0.top.equalTo(content1Label.snp.bottom).offset(18)
            $0.height.equalTo(86)
        }
        
        saveButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(17)
            $0.height.equalTo(saveButton.snp.width).multipliedBy(0.14)
        }
        
        cancelButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(saveButton.snp.leading)
            $0.bottom.equalTo(saveButton.snp.top).offset(-5)
            $0.height.equalTo(saveButton.snp.height)
        }
        
    }
}

extension UploadDocumentsView {
    
    @objc func certificateUploadButtonTapped(sender: UIButton!) {
                certificateUploadButtonActionHandler?()
    }
    
}
