//
//  HomeCollectionViewCell.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/23.
//

import SnapKit
import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    private var shadowView: UIView!

    private lazy var nicknameLabel: NanumLabel = {
        let label = NanumLabel(weightType: .EB, size: 15)
        label.textColor = .label

        return label
    }()

    private lazy var departmentLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 10)
        label.textColor = .label

        return label
    }()

    private lazy var jobFieldLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 10)
        label.textColor = .label

        return label
    }()
    
    private lazy var introductionLabel: NanumLabel = {
        let label = NanumLabel(weightType: .L, size: 8)
        label.textColor = .label

        return label
    }()

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20.0
        imageView.backgroundColor = .lightGray
        imageView.image = UIImage(named: "ProfileBaseImg")
        imageView.tintColor = .black

        return imageView
    }()
    
    func setup() {
        // shadowView가 없을 때(1번만 생성)
        if shadowView == nil {
            // Create Shadow View
            shadowView = UIView(frame: contentView.bounds)
            
            shadowView.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
            addSubview(shadowView)
            
            // Add a shadow to the view
            shadowView.layer.shadowColor = UIColor.black.cgColor
//            shadowView.layer.shadowOffset = CGSize(width:0, height:1)
            shadowView.layer.shadowRadius = 10
            shadowView.layer.cornerRadius = 20
            shadowView.layer.shadowOpacity = 0.2
            // Set the shadow path
            shadowView.layer.shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: shadowView.layer.cornerRadius).cgPath
            
            // Setup a mask to match the view
            let maskLayer = CAShapeLayer()
            maskLayer.frame = shadowView.bounds
            maskLayer.path = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: shadowView.layer.cornerRadius).cgPath
            
            // Make the mask area bigger than the view, so the shadow itself does not get clipped by the mask
            let shadowBorder:CGFloat = (shadowView.layer.shadowRadius * 2) + 5;
            maskLayer.frame = maskLayer.frame.insetBy(dx:  -shadowBorder, dy:  -shadowBorder)  // Make bigger
            maskLayer.frame = maskLayer.frame.offsetBy(dx: shadowBorder/2, dy: shadowBorder/2) // Move top and left
            
            // Allow for cut outs in the shape
            maskLayer.fillRule = .evenOdd
            
            // Create new path
            let pathMasking = CGMutablePath()
            // Add the outer view frame
            pathMasking.addPath(UIBezierPath(rect: maskLayer.frame).cgPath)
            // Translate into the shape back to the smaller original view's frame start point
            var catShiftBorder = CGAffineTransform(translationX: shadowBorder/2, y: shadowBorder/2)
            // Now add the original path for the cut out the shape of the original view
            pathMasking.addPath(maskLayer.path!.copy(using: &catShiftBorder)!)
            // Set this big rect with a small cutout rect as the mask
            maskLayer.path = pathMasking;
            
            // Set as a mask on the view with the shadow
            shadowView.layer.mask = maskLayer;
            
            // Content view to use
            let contentView = UIView(frame: shadowView.frame)
//            contentView.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.5)
            contentView.center = shadowView.center
            contentView.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
            addSubview(contentView)
            contentView.layer.cornerRadius = shadowView.layer.cornerRadius
        }
        
        setupSubViews()
        
        nicknameLabel.text = "닉네임"
        departmentLabel.text = "학과"
        jobFieldLabel.text = "희망 직무 분야"
        introductionLabel.text = "한 줄 소개"
    }

}

private extension HomeCollectionViewCell {
    func setupSubViews() {
        [profileImageView, nicknameLabel, departmentLabel, jobFieldLabel, introductionLabel]
            .forEach { addSubview($0) }

        profileImageView.snp.makeConstraints {
            $0.width.equalTo(83)
            $0.height.equalTo(91)
            $0.leading.equalToSuperview().inset(20.0)
            $0.centerY.equalToSuperview()
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top).offset(5.0)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(22.0)
            $0.trailing.equalToSuperview()
        }

        departmentLabel.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel)
            $0.trailing.equalTo(nicknameLabel)
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(7.0)
        }

        jobFieldLabel.snp.makeConstraints {
            $0.leading.equalTo(departmentLabel)
            $0.trailing.equalTo(departmentLabel)
            $0.top.equalTo(departmentLabel.snp.bottom).offset(7.0)
        }

        introductionLabel.snp.makeConstraints {
            $0.leading.equalTo(jobFieldLabel)
            $0.trailing.equalTo(jobFieldLabel)
            $0.top.equalTo(jobFieldLabel.snp.bottom).offset(7.0)
        }
        
    }
}
