//
//  HomeCollectionHeaderView.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/24.
//

import SnapKit
import UIKit

/**
 * 홈 화면 상단에 위치한 CollectionHeaderView입니다.
 * 홈 화면 안내 문구와 검색 버튼, 알림창 버튼, 필터 버튼이 있습니다.
 */
class HomeCollectionHeaderView: UICollectionReusableView {
    
    var isSearchBarClosedFromTap: Bool = false
    
    weak var parentViewController: UIViewController?
    
    private let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private lazy var baseColor: UIColor = {
        if uiStyle == .mento {
            return UIColor.BaseGreen!
        } else {
            return UIColor.BaseNavy!
        }
    }()

    lazy var nicknameLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 24)
        
        if uiStyle == .mento {
            label.textColor = UIColor.BaseGreen
        } else {
            label.textColor = UIColor.BaseNavy
        }

        return label
    }()
    
    private lazy var titleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .R, size: 24)
        label.text = "님을 위한"
        label.textColor = .BaseGray900

        return label
    }()
    
    private lazy var subTitleLabel: NanumLabel = {
        let label = NanumLabel(weightType: .EB, size: 34)
        label.textColor = .BaseGray900

        return label
    }()
    
    var leftConstraint: NSLayoutConstraint!
    
    private lazy var expandableView: ExpandableView = {
        let expandableView = ExpandableView()
        
        return expandableView
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "SearchIcon"), for: .normal)
        button.tintColor = .BaseGray700
        button.addTarget(self, action: #selector(toggle), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "직접 검색하기"
        searchBar.backgroundColor = .systemBackground
        searchBar.layer.borderWidth = 2
        
        if uiStyle == .mento {
            searchBar.layer.borderColor = UIColor.BaseGreen?.cgColor
        } else {
            searchBar.layer.borderColor = UIColor.BaseNavy?.cgColor
        }
        
        searchBar.layer.cornerRadius = 10
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
        stackView.spacing = 6
        return stackView
    }()
    
    lazy var departmentFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("학과", for: .normal)
        button.backgroundColor = UIColor.BaseGray700
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "NanumSquareOTFR", size: 15)
        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)

        return button
    }()
    
    lazy var hopeMentoringFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("희망 멘토링", for: .normal)
        button.backgroundColor = UIColor(named: "BaseGray700")
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "NanumSquareOTFR", size: 15)
        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)

        return button
    }()
    
    func setup() {
        nicknameLabel.text = "닉네임"
        subTitleLabel.text = "추천멘티"
        
        setupViews()
        self.bringSubviewToFront(searchButton) // searchButton을 최상단으로 올림
        
        // searchBar 오른쪽에 30만큼 여백을 줌
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: searchBar.frame.height))
        searchBar.searchTextField.rightView = paddingView
        searchBar.searchTextField.rightViewMode = .always
        
    }
    
    func updateUI() {
        departmentFilterButton.layer.cornerRadius = departmentFilterButton.frame.height/2
        hopeMentoringFilterButton.layer.cornerRadius = hopeMentoringFilterButton.frame.height/2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
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
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(10)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(nicknameLabel)
            $0.leading.equalTo(nicknameLabel.snp.trailing).offset(1.0)
        }

        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel)
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(7)
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalTo(subTitleLabel)
            $0.trailing.equalToSuperview().inset(34) // 54
        }

        buttonStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(subTitleLabel)
            $0.top.equalTo(searchButton.snp.bottom).offset(29.68)
            $0.height.equalTo(39)
        }
        
    }
    
    /**
     * 검색 버튼을 클릭하면 검색 창이 왼쪽으로 확장 되도록 합니다.
     * 다시 한 번 더 클릭하면 원상태로 줄어듭니다.
     * searchBar는 expandableView를 부모뷰로 두고 있습니다.
     */
    @objc func toggle() {
        if isSearchBarClosedFromTap == true {
            isSearchBarClosedFromTap = false
            return
        } else {
            
        }
        
        let isOpen = leftConstraint.isActive == true

        leftConstraint.isActive = isOpen ? false : true

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
        
        // 검색 창이 확장 될 때 틴트 색을 변경합니다. 축소시 원래 색으로 돌아옵니다.
        if uiStyle == .mento {
            searchButton.tintColor = isOpen ? UIColor.BaseGray700 : UIColor.BaseGreen
        } else {
            searchButton.tintColor = isOpen ? UIColor.BaseGray700 : UIColor.BaseNavy
        }
        
        
    }
    
}

extension HomeCollectionHeaderView {
    /**
     * 키보드와 검색 창이 열려 있을 때 배경을 클릭하면 키보드와 검색 창을 닫습니다.
     */
    func handleBackgroundTap() {
        
        let isOpen = leftConstraint.isActive == true
        // 애니메이션 적용
        if isOpen {
            isSearchBarClosedFromTap = true
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
            searchButton.tintColor = isOpen ? UIColor(named: "BaseGray700") : UIColor(named: "BaseGreen")
        } else {
            isSearchBarClosedFromTap = false
        }
    }
}

extension HomeCollectionHeaderView: SelectViewControllerDelegate {
    
    @objc private func filterButtonTapped(sender: UIButton) {
        let vc = SelectViewController()
        if sender == departmentFilterButton {
            vc.selectViewControllerDelegate = self
            vc.titleText = "학과 필터"
            vc.style = uiStyle
        } else if sender == hopeMentoringFilterButton {
            vc.selectViewControllerDelegate = self
            vc.titleText = "희망 분야 필터"
            vc.style = uiStyle
        } else {
            vc.selectViewControllerDelegate = self
            vc.titleText = "필터"
        }
        vc.sender = sender

        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 30
            sheet.prefersGrabberVisible = true
        }

        // 부모 뷰 컨트롤러에서 뷰 컨트롤러를 표시합니다.
        parentViewController?.present(vc, animated: true, completion: nil)
    }
    
    func didSelectViewControllerDismiss(elements: [String], selectedElements: [Int], sender: UIButton) {
        // 선택한 데이터가 0개 이상일 때만 데이터 저장 및 뷰 수정
        if selectedElements.count > 0 {
            print(selectedElements)
            if sender == departmentFilterButton {
                departmentFilterButton.backgroundColor = baseColor
            } else {
                hopeMentoringFilterButton.backgroundColor = baseColor
            }
        } else { // 선택한 데이터가 아무것도 없을 때 색을 기본색으로 셋팅
            if sender == departmentFilterButton {
                departmentFilterButton.backgroundColor = .BaseGray700
            } else {
                hopeMentoringFilterButton.backgroundColor = .BaseGray700
            }
        }
    }
    
}
