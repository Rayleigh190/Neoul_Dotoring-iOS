//
//  HomeNetworkService.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/23/23.
//

import Foundation
import Alamofire
import JWTDecode

class HomeNetworkService {
    
    class func fetchUserList(uiStyle: UIStyle, _ completion: @escaping (HomeUserAPIResponse?, Error?) -> Void) {

        let pageSize = 5
        
        var urlToCall:  HomeRouter{
            switch uiStyle {
            case .mento:
                return HomeRouter.menti(size: pageSize)
            case .mentee:
                return HomeRouter.mento(size: pageSize)
            }
        }
        
        APINetworkManager.shared.reloadCredential()
        APINetworkManager
            .shared
            .session
            .request(urlToCall)
            .validate(statusCode: 200...300)
            .responseDecodable(of: HomeUserAPIResponse.self) { response in
                debugPrint(response)
                
                switch response.result {
                case .success(let successData):
                    print("HomeNetworkService - fetchUserList() called()")
                    
                    return completion(successData, nil)
                    
                    // 토큰 재발급은 백엔드에서 status 코드 수정해 줄때 까지 대기
//                    if successData.error?.code == "9001" {
//                        print("HomeNetworkService - fetchUserList() : 토큰 만료")
//                        APINetworkManager.shared.authenticator.handleAuthenticationError(urlRequest: urlToCall.urlRequest!, response: HTTPURLResponse(url: (urlToCall.urlRequest?.url)!, statusCode: 401, httpVersion: "HTTP/1.1", headerFields: nil)!, error: AuthError.tokenExpired)
//                        print("HomeNetworkService - fetchUserList() : 토큰 재발급 완료")
//                        fetchUserList(uiStyle: uiStyle) { response, error in
//                            print("HomeNetworkService - fetchUserList() retry")
//                            return completion(response, nil)
//                        }
//                    }
                    
                case .failure(let error):
                    print("HomeNetworkService - fetchUserList() failed()")
                    return completion(nil, error)
                }
            }
    }
    
    
    class func fetchNextPageUserList(uiStyle: UIStyle, lastID: Int, _ completion: @escaping (HomeUserAPIResponse?, Error?) -> Void) {
        
        let pageSize = 5
        
        var urlToCall:  HomeRouter{
            switch uiStyle {
            case .mento:
                return HomeRouter.mentiPage(size: pageSize, lastMentiId: lastID)
            case .mentee:
                return HomeRouter.mentoPage(size: pageSize, lastMentoId: lastID)
            }
        }
        
        APINetworkManager
            .shared
            .session
            .request(urlToCall)
            .validate(statusCode: 200...300)
            .responseDecodable(of: HomeUserAPIResponse.self) { response in
                
                switch response.result {
                case .success(let successData):
                    print("HomeNetworkService - fetchNextPageUserList() called")
                    
                    return completion(successData, nil)
                    
                case .failure(let error):
                    print("HomeNetworkService - fetchNextPageUserList() failed")
                    
                    return completion(nil, error)
                }
                
            }
        
    }
    
}

