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
        
        // JSON 파일에서 Mock 데이터와 HTTP 상태 코드 설정
        MockAPINetworkManager.shared.setMockDataAndStatusCode(fromJSONFile: "fetchNotificationList", statusCode: 200)
        
        MockAPINetworkManager
            .shared
            .session
            .request(urlToCall)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MatchNotiResponse.self) { response in
                switch response.result {
                case .success(let successData):
                    print("MatchNetworkService - fetchNotificationList() called()")
                    return completion(successData, nil)
                case .failure(let error):
                    print("MatchNetworkService - fetchNotificationList() failed()")
                    return completion(nil, error)
                }
            }
    }
}
