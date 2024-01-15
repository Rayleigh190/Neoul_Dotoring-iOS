//
//  SearchSectionView.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/3/24.
//

import Foundation
import UIKit

class SearchSectionView: UIView {
    
    var cellHeight = 120.0
    let numOfCell = 5
    var parentViewController: UIViewController?

    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .B, size: 17)
        label.text = "직접 찾아 보기"
        return label
    }()
    
    private lazy var switchButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()

    private lazy var progressButton: UnderlineButton = {
        let button = UnderlineButton(text: "진행중", style: .gray)
        return button
    }()
    
    private lazy var deadlineButton: UnderlineButton = {
        let button = UnderlineButton(text: "마감", style: .gray)
        return button
    }()
    
    private lazy var filterButtonStackView: UIStackView = {
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
//        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)

        return button
    }()
    
    lazy var pjtGoalFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로젝트 목표", for: .normal)
        button.backgroundColor = UIColor(named: "BaseGray700")
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "NanumSquareOTFR", size: 15)
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
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        pjtGoalFilterButton.layer.cornerRadius = pjtGoalFilterButton.frame.height / 2
        businessNameFilterButton.layer.cornerRadius = businessNameFilterButton.frame.height / 2
    }

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
        cellHeight = with*0.681
        return CGSize(width: with, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let vc = BusinessDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        parentViewController?.navigationController?.pushViewController(vc, animated: true)
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
        if indexPath.row == 1 { // 마감된 사업이라면
            cell?.shutterView.isHidden = false
            cell?.isUserInteractionEnabled = false
        }
        return cell ?? UICollectionViewCell()
    }
}

// MARK: Private method
private extension SearchSectionView {
    func setupViews() {
        [
            titleLabel,
            switchButtonStackView,
            collectionView,
            filterButtonStackView
        ].forEach { addSubview($0) }
        
        [progressButton, deadlineButton].forEach {switchButtonStackView.addArrangedSubview($0)}
        
        [businessNameFilterButton, pjtGoalFilterButton].forEach {filterButtonStackView.addArrangedSubview($0)}

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(16.0)
        }

        switchButtonStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16.0)
            $0.top.equalTo(titleLabel.snp.top)
            $0.width.equalTo(115)
        }
        
        filterButtonStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.height.equalTo(filterButtonStackView.snp.width).multipliedBy(0.119)
        }

        collectionView.snp.makeConstraints {
            let numOfCellLine = ceil(CGFloat(numOfCell)/2.0)
            $0.top.equalTo(filterButtonStackView.snp.bottom)
            $0.height.equalTo(CGFloat(cellHeight) * numOfCellLine + 5*numOfCellLine + 15) // 셀높이, 셀간 간격, top인셋
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

