//
//  ChannelTableViewCell.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/25/23.
//

import Foundation
import UIKit
import SnapKit

class ChannelTableViewCell: UITableViewCell {
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    lazy var newMessageBadge: UIView = {
        let view = UIView()
        view.backgroundColor = .BaseWarningRed
        view.clipsToBounds = true
        view.layer.cornerRadius = 3.5
        return view
    }()
    
    lazy var chatRoomImageBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .BaseGray100
        view.clipsToBounds = true
        return view
    }()
    
    lazy var chatRoomImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "MentoProfileBaseImg"))
        imageView.contentMode = .scaleAspectFit
        
        if uiStyle == .mento {
            imageView.image = UIImage(named: "MentoProfileBaseImg")
        } else {
            imageView.image = UIImage(named: "MenteeProfileBaseImg")
        }
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return imageView
    }()
    
    lazy var chatRoomNicknameLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 15)
        label.text = "닉네임"
        label.textColor = .BaseGray900
        return label
    }()
    
    lazy var chatRoomDepartmentLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "학과"
        label.textColor = .BaseGray900
        return label
    }()
    
    lazy var chatRoomContentLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 12)
        label.text = "미리보기"
        label.textColor = .BaseGray600
        return label
    }()
    
    lazy var chatRoomDateLabel: NanumLabel = {
        let label = NanumLabel(weightType: .L, size: 10)
        label.text = "6월 19일 14시 55분"
        label.textColor = .BaseGray600
        return label
    }()
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        chatRoomImageBackgroundView.layer.cornerRadius = chatRoomImageBackgroundView.frame.height / 2
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configure() {
        
        [chatRoomImageBackgroundView, chatRoomImageView, newMessageBadge, chatRoomNicknameLabel, chatRoomDepartmentLabel, chatRoomContentLabel, chatRoomDateLabel].forEach{contentView.addSubview($0)}
        
        chatRoomImageBackgroundView.addSubview(chatRoomImageView)
        
        chatRoomImageBackgroundView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(chatRoomNicknameLabel.snp.top)
            $0.bottom.equalTo(chatRoomContentLabel.snp.bottom)
            $0.width.equalTo(chatRoomImageBackgroundView.snp.height)
        }
        
        chatRoomImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        newMessageBadge.snp.makeConstraints {
            $0.width.height.equalTo(7)
            $0.leading.equalTo(chatRoomImageBackgroundView.snp.leading)
            $0.top.equalTo(chatRoomImageBackgroundView.snp.top)
        }
        
        chatRoomNicknameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalTo(chatRoomImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(chatRoomDateLabel.snp.leading).offset(-5)
        }
        
        chatRoomDepartmentLabel.snp.makeConstraints {
            $0.leading.equalTo(chatRoomNicknameLabel.snp.leading)
            $0.top.equalTo(chatRoomNicknameLabel.snp.bottom).offset(5)
            $0.trailing.equalTo(chatRoomDateLabel.snp.trailing)
        }
        
        chatRoomContentLabel.snp.makeConstraints {
            $0.leading.equalTo(chatRoomDepartmentLabel.snp.leading)
            $0.top.equalTo(chatRoomDepartmentLabel.snp.bottom).offset(5)
            $0.trailing.equalTo(chatRoomDateLabel.snp.trailing)
            $0.bottom.equalToSuperview().inset(15)
        }
        
        chatRoomDateLabel.snp.makeConstraints {
            $0.top.equalTo(chatRoomNicknameLabel.snp.top)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
