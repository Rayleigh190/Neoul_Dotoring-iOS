//
//  AccountSetViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/10/01.
//

import UIKit

class AccountSetViewController: UIViewController {
    
    var accountSetView: AccountSetView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setNavigationItems()
    }
    
    override func loadView() {
        super.loadView()
        
        accountSetView = AccountSetView(frame: self.view.frame)
        
        setButtonAddTarget()

        self.view = accountSetView
    }
    
    private func setNavigationItems() {
        navigationItem.title = "계정 설정"
        navigationController?.navigationBar.topItem?.backButtonTitle = "마이페이지"
        navigationController?.navigationBar.tintColor = .label
        
    }

}

extension AccountSetViewController {
    
    func setButtonAddTarget() {
        accountSetView.logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    @objc func logout(sender: UIButton) {
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
    
}

extension AccountSetViewController: CustomAlertDelegate {
    func action() {
        print("로그아웃")
    }
    
    func exit() {
        print("로그아웃 취소")
    }
    
    
}
