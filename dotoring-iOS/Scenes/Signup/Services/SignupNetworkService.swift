//
//  SignupNetworkService.swift
//  dotoring-iOS
//
//  Created by 우진 on 12/21/23.
//

import Foundation
import Alamofire

class SignupNetworkService {
    
    class func fetchFieldList(_ completion: @escaping (MajorsAPIResponse?, Error?) -> Void) {
        
        let urlToCall = SignupRouter.majors
        
        BaseNetworkManager
            .shared
            .session
            .request(urlToCall)
            .validate(statusCode: 200...300)
            .responseDecodable(of: MajorsAPIResponse.self) { response in
                switch response.result {
                case .success(let successData):
                    print("SignupNetworkService - fetchFieldList() called")
                    
                    return completion(successData, nil)
                    
                case .failure(let error):
                    print("SignupNetworkService - fetchFieldList() failed")
                    
                    return completion(nil, error)
                }
            }
    }
}
