//
//  OAuthCredential.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/12/23.
//

import Foundation
import Alamofire

struct OAuthCredential: AuthenticationCredential {
    let accessToken: String
//    let refreshToken: String
//    let userID: String
//    let expiration: Date

    // Require refresh if within 5 minutes of expiration
//    var requiresRefresh: Bool { Date(timeIntervalSinceNow: 60 * 5) > expiration }
    var requiresRefresh: Bool = false
    
}
