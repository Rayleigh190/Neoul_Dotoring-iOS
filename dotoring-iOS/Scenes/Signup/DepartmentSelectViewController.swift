//
//  DepartmentSelectViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/04.
//

import UIKit

class DepartmentSelectViewController: UIViewController {
    
    var selectView: SelectView!
    
    weak var departmentSelectViewControllerDelegate: DepartmentSelectViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = .blue
    }
    
    override func loadView() {
        super.loadView()
        selectView = SelectView(frame: self.view.frame)
        selectView.titleLabel.text = "학과 선택"
        self.view = selectView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // 뷰 사라질때 전체 선택 목록 데이터와 선택한 인덱스 데이터를 넘김
        departmentSelectViewControllerDelegate?.didDepartmentSelectViewControllerDismiss(elements: selectView.elements, selectedElements: selectView.selectedElements)
    }

}
