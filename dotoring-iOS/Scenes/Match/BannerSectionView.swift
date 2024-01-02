//
//  BannerSectionView.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/2/24.
//

import Foundation
import UIKit

class BannerSectionView: UIView {

    let cellWidth = UIScreen.main.bounds.width - 32.0
    let sectionSpacing = 16.0
    let cellSpacing = 5.0
    
    private lazy var bannerSectionTitleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 17)
        label.text = "지금 뜨는 지원사업"
        
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = PagingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: 0, right: sectionSpacing)
        layout.itemSize = CGSize(width: cellWidth, height: (cellWidth*4)/7)
        layout.minimumLineSpacing = cellSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = false
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)

        collectionView.register(
            BannerSectionCollectionViewCell.self,
            forCellWithReuseIdentifier: "BannerSectionCollectionViewCell"
        )

        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        collectionView.reloadData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BannerSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerSectionCollectionViewCell", for: indexPath) as? BannerSectionCollectionViewCell
        cell?.setup()

        return cell ?? UICollectionViewCell()
    }
}

extension BannerSectionView: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: collectionView.frame.width - 32.0, height: frame.width)
//    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
////        UIEdgeInsets(top: 0.0, left: 0, bottom: 0.0, right: 0)
//    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
////        32.0
//        5.0
//    }
}

private extension BannerSectionView {
    func setupViews() {
        [
            bannerSectionTitleLabel,
            collectionView
        ].forEach { addSubview($0) }
        
        bannerSectionTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview()
        }

        collectionView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(bannerSectionTitleLabel.snp.bottom).offset(10)
            $0.height.equalTo(snp.width)
            $0.bottom.equalToSuperview()
        }
    }

}
