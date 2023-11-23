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
    case reIssue // 토큰 재발급

    var baseURL: URL {
        return URL(string: API.BASE_URL)!
    }

    var method: HTTPMethod {
        switch self {
        case .userLogin, .reIssue:
            return .post
        }
    }

    var endPoint: String {
        switch self {
        case .userLogin:
            return "member/login"
        case .reIssue:
            return "api/auth/reIssue"
        }
    }
    
    var parameters : [String: String] {
        switch self {
        case let .userLogin(userID, userPW):
            return ["loginId" : userID, "password" : userPW]
        default:
            return [:]
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
        default:
            break
        }

        return request
    }
}
