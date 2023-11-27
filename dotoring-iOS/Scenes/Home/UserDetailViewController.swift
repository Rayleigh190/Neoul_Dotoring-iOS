//
//  UserDetailViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/07.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var userID: Int?
    var userDetailInfo: UserDetailInfo?
    var userDetailView: UserDetailView!
    var isReportConfirmButtonClicked: Bool = false
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: UserDetailViewController.self, action: .none)
        let blockAction = UIAction(title: "차단", image: UIImage(systemName: "nosign"), handler: blockButtonActionHandler)
        let reportAction = UIAction(title: "신고", image: UIImage(systemName: "exclamationmark.bubble"), handler: reportButtonActionHandler)
        
        barButtonItem.menu = UIMenu(title: "",
                                    image: nil,
                                    identifier: nil,
                                    options: .displayInline,
                                    children: [blockAction, reportAction])
        
        return barButtonItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
        fetchUserDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("보여짐\(isReportConfirmButtonClicked)")
        if isReportConfirmButtonClicked == true {
            let text = "신고는 반대 의견을 나타내는\n기능이 아닙니다.\n신고 사유에 맞지 않는 신고를 했을 경우\n해당 신고는 처리되지 않습니다."

            showAlert(
                alertType: .onlyConfirm,
                alertText: text,
                boldText: "해당 신고는 처리되지 않습니다.",
                confirmButtonText: "확인",
                confirmButtonHighlight: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isReportConfirmButtonClicked = false
    }

    override func loadView() {
        super.loadView()
        
        userDetailView = UserDetailView(frame: self.view.frame)
        
//        setButtonAddTarget()

        self.view = userDetailView
    }
    
    private func setNavigationItems() {
        navigationController?.navigationBar.topItem?.backButtonTitle = "추천 멘티"
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
}

private extension UserDetailViewController {
    
    func blockButtonActionHandler(sender: UIAction!) {
        showAlert(
            alertType: .canCancel,
            alertText: "닉네임 님을\n차단하시겠습니까?",
            highlightText: "차단",
            hasSecondaryText: true,
            secondaryText: "차단 해제는 마이페이지에서 가능합니다.",
            cancelButtonText: "아니오",
            confirmButtonText: "네",
            changeButtonPosition: true,
            cancelButtonHighlight: true)
    }
    
    func reportButtonActionHandler(sender: UIAction!) {
        
        let vc = ReportReasonAlertViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        self.present(vc, animated: true)
    }
    
    /**
     * 응답 받은 멘티 또는 멘토 상세정보를 view에 적용
     */
    func updateUI(userInfo: UserDetailInfo) {
        
        let profileImageURLString = userInfo.profileImage.replacingOccurrences(of: "http://localhost:8080/", with: API.BASE_URL)
        let profileImageURL = URL(string: profileImageURLString)
        let profilePlaceholdImage: UIImage
        
        userDetailView.userDetailProfileCardView.gradeLabel.text = "\(userInfo.grade) 학년"
        userDetailView.userDetailProfileCardView.nicknameLabel.text = userInfo.nickname
        userDetailView.introductionContentLabel.text = userInfo.introduction
        userDetailView.userDetailProfileCardView.departmentLabel.text = userInfo.majors.joined(separator: ", ")
        
        if uiStyle == .mento {
            userDetailView.hopeMentoringContentLabel.text = userInfo.preferredMentoring
            profilePlaceholdImage = UIImage(named: "MenteeProfileBaseImg")!
        } else {
            userDetailView.hopeMentoringContentLabel.text = userInfo.mentoringSystem
            profilePlaceholdImage = UIImage(named: "MentoProfileBaseImg")!
        }
        
        userDetailView.userDetailProfileCardView.profileImageView.kf.setImage(with: profileImageURL, placeholder: profilePlaceholdImage)
        
        let userFieldCount =  userInfo.fields.count
        
        for i in 0..<userFieldCount {
            let fieldRectView = FieldRectView()
            fieldRectView.contentLabel.text = "\(userInfo.fields[i])"
            userDetailView.fieldStackView.addArrangedSubview(fieldRectView)
        }
    }
    
    /**
     * 멘티 또는 멘토 상세정보를 요청하고 받습니다.
     */
    func fetchUserDetail() {
        self.view.makeToastActivity(.center)
        // 예외처리 하기
        guard let unwrappedUserID = userID else { return }
        
        var urlToCall:  HomeRouter{
            switch uiStyle {
            case .mento:
                return HomeRouter.mentiDetail(id: unwrappedUserID)
            case .mentee:
                return HomeRouter.mentoDetail(id: unwrappedUserID)
            }
        }
        
        APINetworkManager
            .shared
            .session
            .request(urlToCall)
            .validate(statusCode: 200...400)
            .responseDecodable(of: UserDetailAPIResponse.self) { response in
                
                switch response.result {
                case .success(let successData):
                    print("UserDetailViewController - fetchUserDetail() called()")
                    self.userDetailInfo = successData.response
                    guard let unwrapedUserDetailInfo = self.userDetailInfo else { return }
                    self.updateUI(userInfo: unwrapedUserDetailInfo)
                case .failure(let error):
                    print("UserDetailViewController - fetchUserDetail() failed()")
                    debugPrint(error)
                }
                
                debugPrint(response)
            }
        self.view.hideToastActivity()
    }
}

extension UserDetailViewController: CustomAlertDelegate {
    func action() {
        return
    }
    
    func exit() {
        return
    }
    
}
