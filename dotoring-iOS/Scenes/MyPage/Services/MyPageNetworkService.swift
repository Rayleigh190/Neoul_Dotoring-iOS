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
    
    
    class func patchMentoringMethod(uiStyle: UIStyle, text: String, _ completion: @escaping (MyPageResponse?, Error?) -> Void) {
               
        var urlToCall: MyPageRouter {
            switch uiStyle {
            case .mento:
                return MyPageRouter.editMentoMentoringSys(text: text)
            case .mentee:
                return MyPageRouter.editMentiMentoringSys(text: text)
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
                    print("MyPageNetworkService - patchMentoringMethod() called()")
                    return completion(successData, nil)
                case .failure(let error):
                    print("MyPageNetworkService - patchMentoringMethod() failed()")
                    return completion(nil, error)
                }
            }
    }
    
    
    class func patchTags(uiStyle: UIStyle, tags: [String], _ completion: @escaping (MyPageResponse?, Error?) -> Void) {
               
        var urlToCall: MyPageRouter {
            switch uiStyle {
            case .mento:
                return MyPageRouter.editMentoTags(tags: tags)
            case .mentee:
                return MyPageRouter.editMentiTags(tags: tags)
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
                    print("MyPageNetworkService - patchTags() called()")
                    return completion(successData, nil)
                case .failure(let error):
                    print("MyPageNetworkService - patchTags() failed()")
                    return completion(nil, error)
                }
            }
    }
    
    
    class func putMyInfo(uiStyle: UIStyle, myData: SignupData, _ completion: @escaping (MyPageResponse?, Error?) -> Void) {
        var urlToCall: MyPageRouter {
            switch uiStyle {
            case .mento:
                return MyPageRouter.editMentoInfo(data: myData)
            case .mentee:
                return MyPageRouter.editMentiInfo(data: myData)
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
                    print("MyPageNetworkService - putMyInfo() called()")
                    return completion(successData, nil)
                case .failure(let error):
                    print("MyPageNetworkService - putMyInfo() failed()")
                    return completion(nil, error)
                }
            }
    }
}
