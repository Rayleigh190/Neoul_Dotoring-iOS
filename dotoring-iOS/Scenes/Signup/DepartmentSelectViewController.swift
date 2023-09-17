//
//  DepartmentSelectViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/04.
//

import UIKit

class DepartmentSelectViewController: UIViewController {
    
    var selectView: SelectView!

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

}
