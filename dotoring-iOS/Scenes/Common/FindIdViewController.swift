//
//  FindIdViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/28.
//

import SnapKit
import UIKit

class FindIdViewController: UIViewController {
    
    var findIdView: FindIdView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setNavigationItems()
        setupSubVies()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    override func loadView() {
        super.loadView()
        
        findIdView = FindIdView(frame: self.view.frame)
        
        findIdView.authButtonActionHandler = { [weak self] in
            self?.handleAuthButtonTapped()
        }
        
        self.view = findIdView
    }
    
    private func setNavigationItems() {
        navigationItem.title = "아이디 찾기"
        navigationController?.navigationBar.topItem?.backButtonTitle = "로그인"
        navigationController?.navigationBar.tintColor = .label
        
    }
    
    func handleAuthButtonTapped() {
        let vc = FindIdCheckViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


private extension FindIdViewController {
    
    func setupSubVies() {

    }
}
