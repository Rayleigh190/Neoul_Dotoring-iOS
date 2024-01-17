//
//  MyInfoEditViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/16/24.
//

import UIKit

class MyInfoEditViewController: UIViewController {
    var myPageView: MyPageView!
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setAddTarget()
    }
    
    override func loadView() {
        super.loadView()
        myPageView = MyPageView(isEditable: true)
        self.view = myPageView
    }
    
    func setupNavigationController() {
        navigationItem.title = "내 정보 수정"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .BaseGray900
    }
    
    func setAddTarget() {
        myPageView.fieldButton.addTarget(self, action: #selector(selectTextFieldTapped), for: .touchUpInside)
        myPageView.departmentButton.addTarget(self, action: #selector(selectTextFieldTapped), for: .touchUpInside)
    }

}

extension MyInfoEditViewController: SelectViewControllerDelegate {
    func didSelectViewControllerDismiss(elements: [String], selectedElements: [Int], sender: UIButton) {
        print(selectedElements)
        return
    }
    
    @objc func selectTextFieldTapped(sender: UIButton) {
        let vc = SelectViewController()
        if sender == myPageView.fieldButton {
            vc.selectViewControllerDelegate = self
            vc.titleText = "멘토링 분야 선택"
            vc.style = uiStyle
            vc.elements = ["1", "2"]
            vc.previousSelectedElements = []
        } else if sender == myPageView.departmentButton {
            vc.selectViewControllerDelegate = self
            vc.titleText = "학과 선택"
            vc.style = uiStyle
            vc.elements = ["1", "2"]
            vc.previousSelectedElements = []
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
       present(vc, animated: true)
    }
}
