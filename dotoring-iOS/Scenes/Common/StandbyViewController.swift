//
//  StandbyViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/31/24.
//

import UIKit
import Lottie
import SnapKit

class StandbyViewController: UIViewController {
    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupAnimation()
        view.backgroundColor = .BaseGray900
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deleteUserAccountInfo()
    }
    
    func setupNavigationController() {
        navigationController?.navigationBar.tintColor = .white
    }
    
    func setupAnimation() {
        animationView = .init(name: "StandbyAnimation")
        animationView!.frame = self.view.bounds
        animationView!.center = self.view.center
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        self.view.addSubview(animationView!)
        animationView!.play()
        
        animationView!.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func deleteUserAccountInfo() {
        // 자동 로그인 id, pw 삭제
        if let _ = KeyChain.read(key: KeyChainKey.userID) {
            KeyChain.delete(key: KeyChainKey.userID)
            KeyChain.delete(key: KeyChainKey.userPW)
            print("StandbyViewController - deleteUserAccountInfo() : ID, PW 삭제 완료")
        }
        // 인증, 재인증 토큰 삭제
        if let _ = KeyChain.read(key: KeyChainKey.accessToken) {
            KeyChain.delete(key: KeyChainKey.accessToken)
            print("StandbyViewController - deleteUserAccountInfo() : accessToken 삭제 완료")
        }
    }
}
