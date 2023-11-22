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
        
        //present
        // Get the topmost view controller
        if let topController = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow })?.rootViewController {
            
            // Present the alert on the topmost view controller
            topController.present(alert, animated: true, completion: nil)
        }
    }
    
}
