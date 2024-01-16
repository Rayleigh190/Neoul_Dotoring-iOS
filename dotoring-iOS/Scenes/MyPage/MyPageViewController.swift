//
//  MyPageViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/30.
//

import UIKit

class MyPageViewController: UIViewController {
    
    var myPageView: MyPageView!
    
    private let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()
    
    private lazy var floatingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "MyPageFloatingImgBtn")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 60/2
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4.0
        if uiStyle == .mento {
            button.tintColor = .BaseGreen
        } else {
            button.tintColor = .BaseNavy
        }
        let infoEditAction = UIAction(
            title: "내 정보 수정", 
            image: UIImage(systemName: "pencil"),
            handler: mentorignMethodButtonTapped
        )
        let methodEditAction = UIAction(
            title: "멘토링 방식 수정", 
            image: UIImage(systemName: "doc.text.magnifyingglass"),
            handler: accountSetButtonTapped
        )
        button.showsMenuAsPrimaryAction = true
        button.menu = UIMenu(
            title: "",
            image: nil,
            identifier: nil,
            options: .displayInline,
            children: [infoEditAction, methodEditAction]
        )
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupSubViews()
        setButtonAddTarget()
    }
    
    override func loadView() {
        super.loadView()
        myPageView = MyPageView(frame: self.view.frame)
        self.view = myPageView
    }
    
    func setupNavigationController() {
        navigationItem.title = "마이페이지"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

private extension MyPageViewController {
    func setupSubViews() {
        [floatingButton].forEach {
            view.addSubview($0)
        }
        
        floatingButton.snp.makeConstraints {
            $0.width.height.equalTo(60)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
}

extension MyPageViewController {
    func setButtonAddTarget() {
        myPageView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    func mentorignMethodButtonTapped(sender: UIAction!) {
        let vc = MentoringMethodSetViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func accountSetButtonTapped(sender: UIAction!) {
        let vc = AccountSetViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func logoutButtonTapped(sender: UIButton) {
        showAlert(
            alertType: .canCancel,
            alertText: "정말 로그아웃\n하시겠습니까?",
            highlightText: "로그아웃",
            contentFontSieze: .large,
            hasSecondaryText: true,
            cancelButtonText: "아니오",
            confirmButtonText: "네",
            changeButtonPosition: true,
            cancelButtonHighlight: true
        )
    }
    
//    @objc func showAlet(sender: UIButton!) {
//        print("show alert")
//        showAlert(
//            alertType: .canCancel,
//            alertText: "소속, 분야, 연차, 졸업 학과 수정 시\n새로운 증빙서류가 요청됩니다.\n계속하시겠습니까?",
//            highlightText: "새로운 증빙서류",
//            hasSecondaryText: true,
//            secondaryText: "승인에 최대 3일의 시간이 소요됩니다.",
//            cancelButtonText: "아니오",
//            confirmButtonText: "네",
//            confirmButtonHighlight: true
//        )
//    }
    
}

extension MyPageViewController: CustomAlertDelegate {
    
    func deleteUserAccountInfo() {
        // 자동 로그인 id, pw 삭제
        if let _ = KeyChain.read(key: KeyChainKey.userID) {
            KeyChain.delete(key: KeyChainKey.userID)
            KeyChain.delete(key: KeyChainKey.userPW)
            print("AccountSetVC - deleteUserAccountInfo() : ID, PW 삭제 완료")
        }
        // 인증, 재인증 토큰 삭제
        if let _ = KeyChain.read(key: KeyChainKey.accessToken) {
            KeyChain.delete(key: KeyChainKey.accessToken)
            print("AccountSetVC - deleteUserAccountInfo() : accessToken 삭제 완료")
        }
    }
    
    func action() {
        print("AccountSetViewController - logoutButtonTapped() called")
        deleteUserAccountInfo()
        
        let vc = UINavigationController(rootViewController: LoginViewController())
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func exit() {
        print("로그아웃 취소")
    }
    
    
}
