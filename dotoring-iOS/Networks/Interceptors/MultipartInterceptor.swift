//
//  MultipartInterceptor.swift
//  dotoring-iOS
//
//  Created by 우진 on 12/30/23.
//

import Foundation
import Alamofire

class MultipartInterceptor: RequestInterceptor {
    
    // request 전에 가로채서 세팅할 수 있습니다.
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("MultipartInterceptor - adapt() called")
        
        var request = urlRequest
        
//        request.addValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("MultipartInterceptor - retry() called")
//        guard let statusCode = request.response?.statusCode else {
//            // statusCode가 없으면 아무것도 하지 않음
//            completion(.doNotRetry)
//            return
//        }
        
        completion(.doNotRetry)
    }
    
}
