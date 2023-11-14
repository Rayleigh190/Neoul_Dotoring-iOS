//
//  HomeViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/23.
//

import SnapKit
import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    var myNickName = "닉네임"
    var users: [HomeUser] = []
    
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
        fetchUserList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // navigationBar 때문에 상단 여백이 맞지 않아 안 보이게 처리합니다.
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

}

extension HomeViewController: UICollectionViewDataSource {
    /**
     * collectionView에 재사용 가능한 Cell을 설정합니다.
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as? HomeCollectionViewCell
        let profileImageURL = URL(string: users[indexPath.row].profileImage)
        
        cell?.setup()
        cell?.nicknameLabel.text = users[indexPath.row].nickname
        cell?.departmentLabel.text = users[indexPath.row].majors.joined(separator: ", ")
        cell?.jobFieldLabel.text = users[indexPath.row].fields.joined(separator: ", ")
        cell?.profileImageView.kf.setImage(with: profileImageURL)
        if uiStyle == .mento {
            cell?.introductionLabel.text = users[indexPath.row].preferredMentoringSystem
        } else {
            cell?.introductionLabel.text = users[indexPath.row].mentoringSystem
        }

        return cell ?? UICollectionViewCell()
    }
    
    /**
     * collectionView의 Cell의 개수를 설정합니다.
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    /**
     * collectionView의 Header를 설정합니다.
     */
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard
            kind == UICollectionView.elementKindSectionHeader,
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "HomeCollectionHeaderView",
                for: indexPath
            ) as? HomeCollectionHeaderView
        else { return UICollectionReusableView() }
        header.parentViewController = self // 헤더뷰의 부모뷰를 셀프로 셋팅
        header.setup()
        header.nicknameLabel.text = myNickName

        return header
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    /**
     * collectionViewCell의 사이즈(가로, 세로)를 설정합니다.
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width - 32
        let height: CGFloat = 170
        return CGSize(width: width, height: height)
    }
    
    /**
     * collectionHeaderView의 사이즈(가로, 세로)를 설정합니다.
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 160)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    /**
     * collectionViewCell이 클릭 되었을 때 행동을 정의합니다.
     * 유저 리스트 중 하나가 클릭 되었을 때 유저 디테일 화면으로 이동합니다.
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        let vc = UserDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

private extension HomeViewController {
    func setupSubViews() {
        
        [backgroundImageView, collectionView].forEach { view.addSubview($0) }
        
        backgroundImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(00.0)
            $0.bottom.equalToSuperview().inset(80)
        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // UITapGestureRecognizer를 추가하여 배경 터치 시 키보드를 내릴 수 있도록 합니다.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false //
        
    }
    
    @objc private func handleBackgroundTap() {
        if let headerView = collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader).first as? HomeCollectionHeaderView {
            headerView.handleBackgroundTap()
        }
    }
    
}

extension HomeViewController {
    
    /**
     * 추천 멘티 또는 멘토 리스트를 요청하고 받습니다.
     */
    func fetchUserList() {
        
        var urlToCall:  HomeRouter{
            switch uiStyle {
            case .mento:
                return HomeRouter.menti(size: 10)
            case .mentee:
                return HomeRouter.mento(size: 10)
            }
        }
        
        HomeNetworkManager
            .shared
            .session
            .request(urlToCall)
            .validate(statusCode: 200...400)
            .responseDecodable(of: HomeUserAPIResponse.self) { response in
                
                switch response.result {
                case .success(let successData):
                    print("HomeViewController - fetchUserList() called()")
                    self.users = successData.response.content
                    self.myNickName = successData.response.pageable.nickname
                    self.collectionView.reloadData()
                case .failure(let error):
                    print("HomeViewController - fetchUserList() failed()")
                    debugPrint(error)
                }
                
                debugPrint(response)
            }
        
    }
    
}


