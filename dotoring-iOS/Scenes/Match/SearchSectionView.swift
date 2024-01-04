//
//  SearchSectionView.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/3/24.
//

import Foundation
import UIKit

class SearchSectionView: UIView {
    
    let cellHeight = 120
    let numOfCell = 5

    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 17)
        label.text = "직접 찾아 보기"

        return label
    }()

    private lazy var showAllAppsButton: UIButton = {
        let button = UIButton()
        button.setTitle("모두 보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)

        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 6
        return stackView
    }()
    
    lazy var businessNameFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("지원사업명", for: .normal)
        button.backgroundColor = UIColor.BaseGray700
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "NanumSquareOTFR", size: 15)
        button.layer.cornerRadius = 39/2
//        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)

        return button
    }()
    
    lazy var pjtGoalFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로젝트 목표", for: .normal)
        button.backgroundColor = UIColor(named: "BaseGray700")
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "NanumSquareOTFR", size: 15)
        button.layer.cornerRadius = 39/2
//        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)

        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 7.0
        layout.sectionInset = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 0.0, right: 15.0)

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.register(
            SearchSectionCollectionViewCell.self,
            forCellWithReuseIdentifier: "SearchSectionCollectionViewCell"
        )

        return collectionView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupViews()
        collectionView.reloadData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let with = (collectionView.frame.width - 37)/2
        return CGSize(width: with, height: with*0.681)
    }
}

extension SearchSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numOfCell
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SearchSectionCollectionViewCell",
            for: indexPath
        ) as? SearchSectionCollectionViewCell
        cell?.setup()

        return cell ?? UICollectionViewCell()
    }
}

// MARK: Private method
private extension SearchSectionView {
    func setupViews() {
        [
            titleLabel,
            showAllAppsButton,
            collectionView,
            buttonStackView
        ].forEach { addSubview($0) }
        
        [businessNameFilterButton, pjtGoalFilterButton].forEach {buttonStackView.addArrangedSubview($0)}

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(16.0)
            $0.trailing.equalTo(showAllAppsButton.snp.leading).offset(8.0)
        }

        showAllAppsButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalTo(titleLabel.snp.bottom)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.height.equalTo(39)
        }

        collectionView.snp.makeConstraints {
            let numOfCellLine = ceil(CGFloat(numOfCell)/2.0)
            $0.top.equalTo(buttonStackView.snp.bottom)
            $0.height.equalTo(CGFloat(cellHeight) * numOfCellLine + 5*numOfCellLine + 15) // 셀높이, 셀간 간격, top인셋
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

