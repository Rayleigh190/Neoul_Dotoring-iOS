//
//  MentoSignup5ViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/24.
//

import UIKit

class MentoSignup5ViewController: UIViewController {

    var signup5View: Signup5View!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func loadView() {
        super.loadView()
        
        signup5View = Signup5View(frame: self.view.frame)
        self.view = signup5View
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.setAnimationsEnabled(false)
    }
    
}
