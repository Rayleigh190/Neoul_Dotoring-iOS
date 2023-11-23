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
    var lastID: Int = 0
    var isLastPage: Bool = false
    var isPaging: Bool = false
    var isShowingToast: Bool = false
    var isCollectionViewRefreshing: Bool = false
    
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
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshUserList), for: .valueChanged)
        
        return refreshControl
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
        collectionView.refreshControl = refreshControl

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
        
        if users.count > 0 {
            let profileImageURLString = users[indexPath.row].profileImage.replacingOccurrences(of: "http://localhost:8080/", with: API.BASE_URL)
            let profileImageURL = URL(string: profileImageURLString)
            let profilePlaceholdImage: UIImage
            
            cell?.setup()
            cell?.nicknameLabel.text = users[indexPath.row].nickname
            cell?.departmentLabel.text = users[indexPath.row].majors.joined(separator: ", ")
            cell?.jobFieldLabel.text = users[indexPath.row].fields.joined(separator: ", ")
            if uiStyle == .mento {
                cell?.introductionLabel.text = users[indexPath.row].preferredMentoringSystem
                profilePlaceholdImage = UIImage(named: "MenteeProfileBaseImg")!
            } else {
                cell?.introductionLabel.text = users[indexPath.row].mentoringSystem
                profilePlaceholdImage = UIImage(named: "MentoProfileBaseImg")!
            }
            cell?.profileImageView.kf.setImage(with: profileImageURL, placeholder: profilePlaceholdImage)
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
        let vc = UserDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.userID = users[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 페이징
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        // 스크롤이 테이블 뷰 Offset의 끝에 가게 되면 다음 페이지를 호출합니다.
        if offsetY > (contentHeight - height) {
            if isPaging == false && !isLastPage {
                fetchNextPageUserList()
            }
            if isLastPage && isShowingToast == false{
                self.view.makeToast("마지막 페이지입니다.", duration: 1, position: .bottom)
            }
            
        }
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
     * colectionView의 멘티 또는 멘티 리스트를 새로고침 합니다.
     */
    @objc func refreshUserList() {
        isCollectionViewRefreshing = true
        fetchUserList()
    }
    
    /**
     * 추천 멘티 또는 멘토 리스트를 요청하고 받습니다.
     */
    func fetchUserList() {
        if isCollectionViewRefreshing {
            users.removeAll()
        } else {
            self.view.makeToastActivity(.center)
        }

        let pageSize = 5
        
        var urlToCall:  HomeRouter{
            switch uiStyle {
            case .mento:
                return HomeRouter.menti(size: pageSize)
            case .mentee:
                return HomeRouter.mento(size: pageSize)
            }
        }
        
        HomeNetworkService.fetchUserList(uiStyle: uiStyle) { response, error in
            
            if error != nil {
                // 추천 유저 요청 에러 발생
                print("추천 유저 요청 에러 발생 : \(error?.asAFError?.responseCode ?? 0)")
                if let statusCode = error?.asAFError?.responseCode {
                    Alert.showAlert(title: "추천 유저 요청 에러 발생", message: "\(statusCode)")
                } else {
                    Alert.showAlert(title: "추천 유저 요청 에러 발생", message: "네트워크 연결을 확인하세요.")
                }
            } else {
                if response?.success == true {
                    guard let data = response?.response else { return }

                    self.users = data.content
                    self.myNickName = data.pageable.nickname
                    if let lastID = data.content.last?.id {
                        self.lastID = lastID
                    }
                    self.isLastPage = data.last
                    self.collectionView.reloadData()
                } else {
                    Alert.showAlert(title: "오류", message: "알 수 없는 오류입니다. 다시 시도해 주세요. code : \(response?.error?.code ?? "0")")
                }
            }
        }

        if isCollectionViewRefreshing {
            self.refreshControl.endRefreshing()
            isCollectionViewRefreshing = false
        } else {
            self.view.hideToastActivity()
        }
    }
    
    /**
     * 추천 멘티 또는 멘토 리스트의 다음 페이지를 요청하고 받습니다.
     */
    func fetchNextPageUserList() {
        self.view.makeToastActivity(.center)
        isPaging = true
        let pageSize = 5
        
        var urlToCall:  HomeRouter{
            switch uiStyle {
            case .mento:
                return HomeRouter.mentiPage(size: pageSize, lastMentiId: lastID)
            case .mentee:
                return HomeRouter.mentoPage(size: pageSize, lastMentoId: lastID)
            }
        }
        
        HomeNetworkManager
            .shared
            .session
            .request(urlToCall)
            .validate(statusCode: 200...300)
            .responseDecodable(of: HomeUserAPIResponse.self) { response in
                
                switch response.result {
                case .success(let successData):
                    print("HomeViewController - fetchNextPageUserList() called")
                    
                    guard let data = successData.response else { return }
                    
                    self.users.append(contentsOf: data.content)
                    if let lastID = data.content.last?.id {
                        self.lastID = lastID
                    }
                    self.isLastPage = data.last
                    self.collectionView.reloadData()
                    self.isPaging = false
                case .failure(let error):
                    print("HomeViewController - fetchNextPageUserList() failed")
                    debugPrint(error)
                    self.isPaging = false
                }
                
                debugPrint(response)
            }
        self.view.hideToastActivity()
    }
    
}


