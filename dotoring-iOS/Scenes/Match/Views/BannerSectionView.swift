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
    lazy var cellHeight = (cellWidth*4)/7
    let sectionSpacing = 16.0
    let cellSpacing = 5.0
    // 현재 배너 페이지 체크 변수 (자동 스크롤할 때 필요)
    let numOfBannerPage: Int = 5
    var currentBannerPage: Int = 0
    
    private lazy var bannerSectionTitleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 17)
        label.text = "지금 뜨는 지원사업"
        
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = PagingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: 0, right: sectionSpacing)
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
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
    
    private lazy var bannerPageNumBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .BaseGray100
        view.layer.cornerRadius = 21/2
        
        return view
    }()
    
    private lazy var bannerPageNumLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 13)
        label.text = "1 / \(numOfBannerPage)"
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        collectionView.reloadData()
        bannerTimer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BannerSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numOfBannerPage
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentBannerPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        updateBannerPageNumLabel()
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        currentBannerPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//        updateBannerPageNumLabel()
//    }
}

private extension BannerSectionView {
    
    func updateBannerPageNumLabel() {
        bannerPageNumLabel.text = "\(currentBannerPage+1) / \(numOfBannerPage)"
    }
    
    // 2.5초마다 실행되는 타이머
    func bannerTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { (Timer) in
            self.bannerMove()
        }
    }
    // 배너 움직이는 매서드
    func bannerMove() {
        // 현재페이지가 마지막 페이지일 경우
        if currentBannerPage == numOfBannerPage - 1 {
        // 맨 처음 페이지로 돌아감
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
            currentBannerPage = 0
            updateBannerPageNumLabel()
            return
        }
        // 다음 페이지로 전환
        currentBannerPage += 1
        collectionView.scrollToItem(at: IndexPath(item: currentBannerPage, section: 0), at: .centeredHorizontally, animated: true)
        updateBannerPageNumLabel()
    }
    
    func setupViews() {
        [
            bannerSectionTitleLabel,
            collectionView,
            bannerPageNumBackView,
            bannerPageNumLabel
        ].forEach { addSubview($0) }
        
        bannerPageNumBackView.addSubview(bannerPageNumLabel)
        
        bannerSectionTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview()
        }

        collectionView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(bannerSectionTitleLabel.snp.bottom).offset(10)
            $0.height.equalTo(cellHeight+15)
            $0.bottom.equalToSuperview()
        }
        
        bannerPageNumBackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(60)
            $0.height.equalTo(21)
        }
        
        bannerPageNumLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

}
