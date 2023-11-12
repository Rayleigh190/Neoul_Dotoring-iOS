//
//  Bundle.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/9/23.
//

import Foundation

extension Bundle {
    
    var BASE_API_URL: String {
        guard let file = self.path(forResource: "Secrets", ofType: "plist") else{return ""}
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["BASE_API_URL"] as? String else {fatalError("Secrets에 BASE_API_URL을 설정해 주세요.")}
        
        return key
    }
    
}
