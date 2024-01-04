//
//  SearchSectionCollectionViewCell.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/3/24.
//

import Foundation
import UIKit

final class SearchSectionCollectionViewCell: UICollectionViewCell {
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()

    private lazy var businessNameLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 20)
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "지원사업명"

        return label
    }()
    
    private lazy var nicknameLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 15)
        label.text = "닉네임"
        if uiStyle == .mento {
            label.textColor = .BaseGreen
        } else {
            label.textColor = .BaseNavy
        }
        
        return label
    }()

    private lazy var dateLabel: NanumLabel = {
        let label = NanumLabel(weightType: .L, size: 13)
        label.textColor = .BaseGray600
        label.text = "00월 00일"

        return label
    }()
    
    private lazy var participantsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ParticipantsImg")
        
        return imageView
    }()
    
    private lazy var participantsCountLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 13)
        label.text = "10"
        label.textColor = .BaseGray600
        
        return label
    }()

    func setup() {
        setupLayout()

//        titleLabel.text = rankingFeature.title
//        descriptionLabel.text = rankingFeature.description
//        inAppPurchaseInfoLabel.isHidden = !rankingFeature.isInPurchaseApp
        
        // 셀에 둥근 코너와 그림자 적용
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 10.0
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowRadius = 4.0
    }

}

// MARK: Private
private extension SearchSectionCollectionViewCell {
    func setupLayout() {
        [
           businessNameLabel,
           dateLabel,
           nicknameLabel,
           participantsImageView,
           participantsCountLabel
        ].forEach { contentView.addSubview($0) }

        businessNameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(14)
            $0.top.equalToSuperview().inset(12)
        }

        dateLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(14)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.trailing.equalTo(dateLabel.snp.trailing)
            $0.bottom.equalTo(dateLabel.snp.top).offset(-5)
        }
        
        participantsImageView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(14)
            $0.width.equalTo(12)
        }
        
        participantsCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(participantsImageView)
            $0.leading.equalTo(participantsImageView.snp.trailing).offset(2)
        }
    }
}

