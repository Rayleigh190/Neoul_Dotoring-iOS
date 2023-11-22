//
//  Router.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/9/23.
//

import Foundation
import Alamofire

// 최상단 API Router
enum BaseRouter: URLRequestConvertible {
    
    case userLogin(userID: String, userPW: String) // 로그인
//    case post([String: String])
//    case post([String: String])
//    case post(term: String)

    var baseURL: URL {
        return URL(string: API.BASE_URL)!
    }

    var method: HTTPMethod {
        switch self {
        case .userLogin:
            return .post
//        case .post:
//            return .post
        }
    }

    var endPoint: String {
        switch self {
        case .userLogin:
            return "member/login"
//        case .post:
//            return "post"
        }
    }
    
    var parameters : [String: String] {
        switch self {
        case let .userLogin(userID, userPW):
         return ["loginId" : userID, "password" : userPW]
//        default:
//            <#code#>
        }
    }

    func asURLRequest() throws -> URLRequest {
        // 실제 api가 호출 되면서 발동 되는 부분
        
        let url = baseURL.appendingPathComponent(endPoint)
        
        print("BaseRouter - asURLRequest() url : \(url)")
        
        var request = URLRequest(url: url)
        request.method = method

        switch self {
        case .userLogin:
            request.httpBody = try JSONEncoder().encode(parameters)
//        case let .post(parameters):
//            request = try JSONParameterEncoder().encode(parameters, into: request)
        }

        return request
    }
}
