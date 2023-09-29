//
//  HomeViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/23.
//

import SnapKit
import UIKit

class HomeViewController: UIViewController {
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        if uiStyle == .mento {
            imageView.image = UIImage(named: "MentoHomeBackgroundImg")
        } else {
            imageView.image = UIImage(named: "MenteeHomeBackgroundImg")
        }
        

        return imageView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "homeCell")
        collectionView.register(
            HomeCollectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "HomeCollectionHeaderView"
        )

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupSubViews()
    }

}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as? HomeCollectionViewCell
        cell?.setup()

        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard
            kind == UICollectionView.elementKindSectionHeader,
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "HomeCollectionHeaderView",
                for: indexPath
            ) as? HomeCollectionHeaderView
        else { return UICollectionReusableView() }

        header.setup()

        return header
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width - 108.0
        let height: CGFloat = 127.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width - 108.0, height: 230.0)
    }
}

private extension HomeViewController {
    func setupSubViews() {
        
        [backgroundImageView, collectionView].forEach { view.addSubview($0) }
        
        backgroundImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(00.0)
            $0.bottom.equalToSuperview().inset(29.66)
        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // UITapGestureRecognizer를 추가하여 배경 터치 시 키보드를 내릴 수 있도록 함
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc private func handleBackgroundTap() {
        if let headerView = collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader).first as? HomeCollectionHeaderView {
            headerView.handleBackgroundTap()
        }
    }
    
}

extension HomeViewController {
    
}


