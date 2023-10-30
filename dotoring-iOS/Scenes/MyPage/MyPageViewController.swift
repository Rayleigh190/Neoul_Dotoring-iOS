//
//  MyPageViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/30.
//

import UIKit

class MyPageViewController: UIViewController {
    
    var myPageView: MyPageView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        super.loadView()
        
        myPageView = MyPageView(frame: self.view.frame)
        self.view = myPageView
    }

}

extension MyPageViewController {
    
    func handleSetMentoringButtonTapped() {
        let vc = MentoringSetViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleSetAccountButtonTapped() {
        let vc = AccountSetViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func handledepartmentButtonTapped() {
        let vc = UploadDocumentsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showAlet(sender: UIButton!) {
        print("show alert")
        showAlert(
            alertType: .canCancel,
            alertText: "소속, 분야, 연차, 졸업 학과 수정 시\n새로운 증빙서류가 요청됩니다.\n계속하시겠습니까?",
            highlightText: "새로운 증빙서류",
            hasSecondaryText: true,
            secondaryText: "승인에 최대 3일의 시간이 소요됩니다.",
            cancelButtonText: "아니오",
            confirmButtonText: "네",
            confirmButtonHighlight: true
        )
    }
    
}

extension MyPageViewController: CustomAlertDelegate {
    func action() {
        print("액션")
    }
    
    func exit() {
        print("엑시트")
    }
    
    
}
