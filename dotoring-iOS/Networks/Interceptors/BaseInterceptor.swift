//
//  BaseInterceptor.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/9/23.
//

import Foundation
import Alamofire

class BaseInterceptor: RequestInterceptor {
    
    // request 전에 가로채서 세팅할 수 있습니다.
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("BaseInterceptor - adapt() called")
        
        var request = urlRequest
        
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Accept")
        
        completion(.success(request))
    }
    
    // 토큰값 없을때 여기서 핸들링하기
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("BaseInterceptor - retry() called")
        
//        guard let statusCode = request.response?.statusCode else {
//            // statusCode가 없으면 아무것도 하지 않음
//            completion(.doNotRetry)
//            return
//        }
        
        completion(.doNotRetry)
    }
    
}
