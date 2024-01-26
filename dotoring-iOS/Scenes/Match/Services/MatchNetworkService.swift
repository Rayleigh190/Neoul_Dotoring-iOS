//
//  MatchNetworkService.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/26/24.
//

import Foundation
import Alamofire

class MatchNetworkService {
    
    class func fetchNotificationList(_ completion: @escaping (MatchNotiResponse?, Error?) -> Void) {
               
        let urlToCall = MatchRouter.notification(goal: "공모전", title: "교학상장", isClose: true)
        
//        MockAPINetworkManager
//            .shared
//            .session
//            .request(urlToCall)
//            .responseDecodable(of: MatchNotiResponse.self) { response in
//                debugPrint(response)
//                switch response.result {
//                case .success(let successData):
//                    print("MatchNetworkService - fetchNotificationList() called()")
//                    return completion(successData, nil)
//                case .failure(let error):
//                    print("MatchNetworkService - fetchNotificationList() failed()")
//                    print("에러: \(error)")
//                               
//                       if let data = response.data,
//                          let utf8Text = String(data: data, encoding: .utf8) {
//                           print("응답 데이터: \(utf8Text)")
//                       }
//                    return completion(nil, error)
//                }
//            }
    }
}
