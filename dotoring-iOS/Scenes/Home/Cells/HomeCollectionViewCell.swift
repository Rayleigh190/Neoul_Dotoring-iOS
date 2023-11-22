//
//  HomeCollectionViewCell.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/23.
//

import SnapKit
import UIKit

/**
 * UICollectionView의 Cell을 정의합니다.
 * 홈 화면 유저 리스트의 Cell을 정의합니다.
 */
class HomeCollectionViewCell: UICollectionViewCell {
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private var shadowView: UIView!

    lazy var nicknameLabel: NanumLabel = {
        let label = NanumLabel(weightType: .EB, size: 20)
        
        if uiStyle == .mento {
            label.textColor = .BaseNavy
        } else {
            label.textColor = .BaseGreen
        }

        return label
    }()

    lazy var departmentLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 17)
        label.textColor = .BaseGray900

        return label
    }()

    lazy var jobFieldLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 15)
        label.textColor = .BaseGray700

        return label
    }()
    
    lazy var introductionLabel: NanumLabel = {
        let label = NanumLabel(weightType: .L, size: 13)
        label.textColor = .BaseGray700
        label.numberOfLines = 0
        label.textAlignment = .justified

        return label
    }()
    
    lazy var profileImageBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .BaseGray100
        view.clipsToBounds = true
        view.layer.cornerRadius = 20.0
       
        return view
    }()

    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        if uiStyle == .mento {
            imageView.image = UIImage(named: "MentoProfileBaseImg")
        } else {
            imageView.image = UIImage(named: "MenteeProfileBaseImg")
        }

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
            // 셀의 배경색을 지정합니다.
            contentView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
            contentView.center = shadowView.center
            contentView.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
            addSubview(contentView)
            contentView.layer.cornerRadius = shadowView.layer.cornerRadius
        }
        
        setupSubViews()
        
//        nicknameLabel.text = "닉네임"
//        departmentLabel.text = "학과"
//        jobFieldLabel.text = "분야"
//        introductionLabel.text = "한 줄 소개"
    }

}

private extension HomeCollectionViewCell {
    func setupSubViews() {
        [profileImageBackgroundView, nicknameLabel, departmentLabel, jobFieldLabel, introductionLabel]
            .forEach { addSubview($0) }
        
        profileImageBackgroundView.addSubview(profileImageView)

        profileImageBackgroundView.snp.makeConstraints {
            $0.width.equalTo(135)
            $0.height.equalTo(148)
            $0.leading.equalToSuperview().inset(18)
            $0.centerY.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.edges.equalToSuperview()
//            $0.height.equalTo(61)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageBackgroundView.snp.top).offset(8)
            $0.leading.equalTo(profileImageBackgroundView.snp.trailing).offset(9)
            $0.trailing.equalToSuperview().offset(-20)
        }

        departmentLabel.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel)
            $0.trailing.equalTo(nicknameLabel)
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(5)
        }

        jobFieldLabel.snp.makeConstraints {
            $0.leading.equalTo(departmentLabel)
            $0.trailing.equalTo(departmentLabel)
            $0.top.equalTo(departmentLabel.snp.bottom).offset(8)
        }

        introductionLabel.snp.makeConstraints {
            $0.leading.equalTo(jobFieldLabel)
            $0.trailing.equalTo(jobFieldLabel)
            $0.top.equalTo(jobFieldLabel.snp.bottom).offset(10)
        }
        
    }
}
