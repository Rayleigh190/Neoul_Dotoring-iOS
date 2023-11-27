//
//  Alert.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/18/23.
//

import Foundation
import UIKit

class Alert {
    
    class func showAlert(title: String, message: String) {
        //UIAlertController
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Button
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(ok)
        
        if let vc = UIApplication.shared.keyWindow?.visibleViewController as? UIViewController { 
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    // 확인 누르면 로그아웃 되어 로그인 화면으로 이동합니다.
    class func showAuthErrorAlert(title: String, message: String) {
        //UIAlertController
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Button
        let ok = UIAlertAction(title: "확인", style: .default) { (action:UIAlertAction!) in
            logout()
        }
        
        alert.addAction(ok)
        
        if let vc = UIApplication.shared.keyWindow?.visibleViewController as? UIViewController {
            vc.present(alert, animated: true, completion: nil)
        }
        
        func logout() {
            deleteUserAccountInfo()
            
            let vc = UINavigationController(rootViewController: LoginViewController())
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            
            //present
            // Get the topmost view controller
            if let topController = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .flatMap({ $0.windows })
                .first(where: { $0.isKeyWindow })?.rootViewController {
                
                // Present the alert on the topmost view controller
                topController.present(vc, animated: true)
            }
        }
        
        func deleteUserAccountInfo() {
            // 자동 로그인 id, pw 삭제
            if let _ = KeyChain.read(key: KeyChainKey.userID) {
                KeyChain.delete(key: KeyChainKey.userID)
                KeyChain.delete(key: KeyChainKey.userPW)
                print("AccountSetVC - deleteUserAccountInfo() : ID, PW 삭제 완료")
            }
            // 인증, 재인증 토큰 삭제
            if let _ = KeyChain.read(key: KeyChainKey.accessToken) {
                KeyChain.delete(key: KeyChainKey.accessToken)
                KeyChain.delete(key: KeyChainKey.refreshToken)
                print("AccountSetVC - deleteUserAccountInfo() : accessToken, refreshToken 삭제 완료")
            }
        }
    }
}

extension UIWindow {
    
    public var visibleViewController: UIViewController? {
        return self.visibleViewControllerFrom(vc: self.rootViewController)
    }
    
    /**
     # visibleViewControllerFrom
     - Author: suni
     - Date:
     - Parameters:
        - vc: rootViewController 혹은 UITapViewController
     - Returns: UIViewController?
     - Note: vc내에서 가장 최상위에 있는 뷰컨트롤러 반환
    */
    public func visibleViewControllerFrom(vc: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return self.visibleViewControllerFrom(vc: nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return self.visibleViewControllerFrom(vc: tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return self.visibleViewControllerFrom(vc: pvc)
            } else {
                return vc
            }
        }
    }
}
