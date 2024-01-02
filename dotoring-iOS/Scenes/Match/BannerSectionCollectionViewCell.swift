//
//  BannerSectionCollectionViewCell.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/2/24.
//

import Foundation
import UIKit

class BannerSectionCollectionViewCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 7.0
        imageView.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()
    
    func setup() {
        setupLayout()

        if let imageURL = URL(string: "https://via.placeholder.com/350x200") {
            imageView.kf.setImage(with: imageURL)
        }
    }
}

private extension BannerSectionCollectionViewCell {
    func setupLayout() {
        [
            imageView
        ].forEach { addSubview($0) }

        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(8.0)
            $0.bottom.equalToSuperview().inset(8.0)
        }
    }

}
