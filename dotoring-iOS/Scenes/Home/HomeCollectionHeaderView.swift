//
//  HomeCollectionHeaderView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/24.
//

import SnapKit
import UIKit

class HomeCollectionHeaderView: UICollectionReusableView {
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()

    private lazy var nicknameLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        
        if uiStyle == .mento {
            label.textColor = UIColor.BaseGreen
        } else {
            label.textColor = UIColor.BaseNavy
        }

        return label
    }()
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 20)
        label.text = "님을 위한"
        label.textColor = .label

        return label
    }()
    
    private lazy var subTitleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .EB, size: 40)
        label.textColor = .label

        return label
    }()
    
    var leftConstraint: NSLayoutConstraint!
    
    private lazy var expandableView: ExpandableView = {
        let expandableView = ExpandableView()
        
        return expandableView
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = UIColor(named: "BaseSecondaryEmhasisGray")
        button.addTarget(self, action: #selector(toggle), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "직접 검색"
        searchBar.backgroundColor = .systemBackground
        searchBar.layer.borderWidth = 2
        
        if uiStyle == .mento {
            searchBar.layer.borderColor = UIColor.BaseGreen?.cgColor
        } else {
            searchBar.layer.borderColor = UIColor.BaseNavy?.cgColor
        }
        
        searchBar.layer.cornerRadius = 20
        searchBar.searchTextField.backgroundColor = .systemBackground
        searchBar.backgroundImage = UIImage() // 위아래 선 지움
        searchBar.translatesAutoresizingMaskIntoConstraints = false // superview가 변함에 따라 subview의 크기를 어떻게 할것인가
        searchBar.searchTextField.leftView = nil // 왼쪽 기본 돋복기 이미지 제거
        searchBar.endEditing(true)
        
        return searchBar
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        return stackView
    }()
    
    lazy var departmentFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("학과", for: .normal)
        button.backgroundColor = UIColor.BaseSecondaryEmhasisGray
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "NanumSquareOTFR", size: 12)
        button.layer.cornerRadius = 17
//        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)

        return button
    }()
    
    lazy var hopeMentoringFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("희망 멘토링", for: .normal)
        button.backgroundColor = UIColor(named: "BaseSecondaryEmhasisGray")
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "NanumSquareOTFR", size: 12)
        button.layer.cornerRadius = 17

        return button
    }()
    
    func setup() {
        nicknameLabel.text = "닉네임"
        subTitleLabel.text = "추천멘티"
        
        setupViews()
        self.bringSubviewToFront(searchButton) // searchButton을 최상단으로 올림
        
        // searchBar 오른쪽에 20만큼 여백을 줌
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: searchBar.frame.height))
        searchBar.searchTextField.rightView = paddingView
        searchBar.searchTextField.rightViewMode = .always
        
    }

}

private extension HomeCollectionHeaderView {
    
    func setupViews() {
        [nicknameLabel, titleLabel, subTitleLabel, buttonStackView, searchButton, expandableView]
            .forEach { addSubview($0) }
        
        expandableView.addSubview(searchBar)
        
        buttonStackView.addArrangedSubview(departmentFilterButton)
        buttonStackView.addArrangedSubview(hopeMentoringFilterButton)
    
        leftConstraint = searchBar.leftAnchor.constraint(equalTo: expandableView.leftAnchor)
        leftConstraint.isActive = false
        searchBar.rightAnchor.constraint(equalTo: expandableView.rightAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: expandableView.topAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: expandableView.bottomAnchor).isActive = true
        
        expandableView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(subTitleLabel)
            $0.leading.equalTo(nicknameLabel)
            $0.height.equalTo(45)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(54.0)
            $0.top.equalToSuperview().inset(95.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(nicknameLabel)
            $0.leading.equalTo(nicknameLabel.snp.trailing).offset(1.0)
        }

        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel)
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(1.0)
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalTo(subTitleLabel)
            $0.trailing.equalToSuperview().inset(65.0) // 54
        }

        buttonStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(subTitleLabel)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(10.0)
            $0.height.equalTo(33.0)
        }
        
    }
    
    @objc func toggle() {

        let isOpen = leftConstraint.isActive == true

        // Inactivating the left constraint closes the expandable header.
        leftConstraint.isActive = isOpen ? false : true

        // Animate change to visible.
        UIView.animate(withDuration: 0.5, animations: {
            self.expandableView.alpha = isOpen ? 0 : 1
            self.expandableView.layoutIfNeeded()
            
            [self.nicknameLabel, self.subTitleLabel, self.titleLabel].forEach { view in
                view.alpha = isOpen ? 1 : 0
                view.layoutIfNeeded()
            }
        })
        
        if !self.leftConstraint.isActive {
            self.endEditing(true)
        } else {
            searchBar.becomeFirstResponder()
        }
        
        if uiStyle == .mento {
            searchButton.tintColor = isOpen ? UIColor.BaseSecondaryEmhasisGray : UIColor.BaseGreen
        } else {
            searchButton.tintColor = isOpen ? UIColor.BaseSecondaryEmhasisGray : UIColor.BaseNavy
        }
        
        
    }
    
}

extension HomeCollectionHeaderView {
    func handleBackgroundTap() {
        
        let isOpen = leftConstraint.isActive == true
        // 애니메이션 적용
        if isOpen {
            // Inactivating the left constraint closes the expandable header.
            leftConstraint.isActive = isOpen ? false : true
            
            UIView.animate(withDuration: 0.5) {
                self.expandableView.alpha = isOpen ? 0 : 1
                self.expandableView.layoutIfNeeded()
                [self.nicknameLabel, self.subTitleLabel, self.titleLabel].forEach { view in
                    view.alpha = isOpen ? 1 : 0
                    view.layoutIfNeeded()
                }
            }
            self.endEditing(true) // 키보드도 함께 내림
            searchButton.tintColor = isOpen ? UIColor(named: "BaseSecondaryEmhasisGray") : UIColor(named: "BaseGreen")
        }
    }
}
