//
//  JobSelectViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/04.
//

import UIKit

class JobSelectViewController: UIViewController {
    
    var selectView: SelectView!

    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = .red
    }
    
    override func loadView() {
        super.loadView()
        selectView = SelectView(frame: self.view.frame)
        selectView.titleLabel.text = "직무 분야 선택"
        self.view = selectView
    }
    

}
