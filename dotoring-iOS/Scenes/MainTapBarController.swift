//
//  MainTapBarController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/08/22.
//

import SnapKit
import UIKit

class MainTapBarController: UITabBarController {

    private lazy var homeViewController: UIViewController = {
        let viewController = HomeViewController()
        let tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(named: "MainTapBarItemHomeUnclickedImg"),
            selectedImage: UIImage(named: "MainTapBarItemHomeClickedImg")
        )
        viewController.tabBarItem = tabBarItem

        return viewController
    }()

    private lazy var matchViewController: UIViewController = {
        let viewController = UIViewController()
        let tabBarItem = UITabBarItem(
            title: "매칭",
            image: UIImage(named: "MainTapBarItemMatchUnclickedImg"),
            selectedImage: UIImage(named: "MainTapBarItemMatchClickedImg")
        )
        viewController.tabBarItem = tabBarItem

        return viewController
    }()
    
    private lazy var chatViewController: UIViewController = {
        let viewController = UIViewController()
        let tabBarItem = UITabBarItem(
            title: "채팅",
            image: UIImage(named: "MainTapBarItemChatUnclickedImg"),
            selectedImage: UIImage(named: "MainTapBarItemChatClickedImg")
        )
        viewController.tabBarItem = tabBarItem

        return viewController
    }()
    
    private lazy var mypageViewController: UIViewController = {
        let viewController = UIViewController()
        let tabBarItem = UITabBarItem(
            title: "마이페이지",
            image: UIImage(named: "MainTapBarItemMypageClickedImg"),
            selectedImage: UIImage(named: "MainTapBarItemMypageUnclickedImg")
        )
        viewController.tabBarItem = tabBarItem

        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapBar()
        viewControllers = [homeViewController, matchViewController, chatViewController, mypageViewController]
        
    }


}

private extension MainTapBarController {
    func setupTapBar() {
        
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()  // Bar의 그림자 제거
        self.tabBar.standardAppearance = appearance
//        self.tabBar.scrollEdgeAppearance = appearance  // 생략 가능 (만약 스크롤 기능 따라 Bar설정 안해줘도 된다면)
        
        tabBar.tintColor = .BaseGreen
        tabBar.backgroundColor = .white

        // Add a radius to the tab bar to create rounded corners
        tabBar.layer.cornerRadius = 20.0
        
        // Apply shadow to the tab bar
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 10
        tabBar.layer.shadowOpacity = 0.3
    }
    
}
