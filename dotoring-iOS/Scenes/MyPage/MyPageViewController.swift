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
