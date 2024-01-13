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
            // Shadow View 생성
            shadowView = UIView(frame: contentView.bounds)
            
            shadowView.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
            addSubview(shadowView)
            
            // view에 shadowView 추가
            shadowView.layer.shadowColor = UIColor.black.cgColor
//            shadowView.layer.shadowOffset = CGSize(width:0, height:1)
            shadowView.layer.shadowRadius = 10
            shadowView.layer.cornerRadius = 20
            shadowView.layer.shadowOpacity = 0.2
            // shadow path 설정
            shadowView.layer.shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: shadowView.layer.cornerRadius).cgPath
            
            // view와 일치하도록 mask 설정
            let maskLayer = CAShapeLayer()
            maskLayer.frame = shadowView.bounds
            maskLayer.path = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: shadowView.layer.cornerRadius).cgPath
            
            // 마스크 영역을 뷰보다 크게 만들어 그림자 자체가 마스크에 의해 잘리지 않도록 함
            let shadowBorder:CGFloat = (shadowView.layer.shadowRadius * 2) + 5;
            maskLayer.frame = maskLayer.frame.insetBy(dx:  -shadowBorder, dy:  -shadowBorder)  // 크게 만듬
            maskLayer.frame = maskLayer.frame.offsetBy(dx: shadowBorder/2, dy: shadowBorder/2) // 위쪽 및 왼쪽으로 이동
            
            // shape에 cut outs 허용
            maskLayer.fillRule = .evenOdd
            
            // 새 path 생성
            let pathMasking = CGMutablePath()
            // 외부 뷰 프레임 추가
            pathMasking.addPath(UIBezierPath(rect: maskLayer.frame).cgPath)
            // 더 작은 original view's 프레임 시작점으로 다시 모양으로 변환
            var catShiftBorder = CGAffineTransform(translationX: shadowBorder/2, y: shadowBorder/2)
            // original 뷰의 모양을 잘라낼 original 경로를 추가
            pathMasking.addPath(maskLayer.path!.copy(using: &catShiftBorder)!)
            // small cuout 사각형을 마스크로 사용하여 big 사각형을 설정
            maskLayer.path = pathMasking;
            
            // shadowView에 마스크로 설정
            shadowView.layer.mask = maskLayer;
            
            // Content view로 사용
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
