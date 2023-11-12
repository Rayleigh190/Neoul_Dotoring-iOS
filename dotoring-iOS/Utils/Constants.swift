//
//  Constants.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/9/23.
//

import Foundation

enum API {
    
    static let BASE_URL : String = Bundle.main.BASE_API_URL
    
}

enum KeyChainKey {
    
    static let accessToken: String = "accessToken"
    static let refreshToken: String = "refreshToken"
    
}
