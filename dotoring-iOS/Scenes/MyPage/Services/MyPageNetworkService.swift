//
//  MyPageNetworkService.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/29/24.
//

import Foundation
import Alamofire

class MyPageNetworkService {
    
    class func fetchMyInfo(uiStyle: UIStyle, _ completion: @escaping (MyPageResponse?, Error?) -> Void) {
               
        var urlToCall: MyPageRouter {
            switch uiStyle {
            case .mento:
                return MyPageRouter.mentoMyPage
            case .mentee:
                return MyPageRouter.mentiMyPage
            }
        }
        
        APINetworkManager
            .shared
            .session
            .request(urlToCall)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MyPageResponse.self) { response in
                switch response.result {
                case .success(let successData):
                    print("MyPageNetworkService - fetchMyInfo() called()")
                    return completion(successData, nil)
                case .failure(let error):
                    print("MyPageNetworkService - fetchMyInfo() failed()")
                    return completion(nil, error)
                }
            }
    }
}
