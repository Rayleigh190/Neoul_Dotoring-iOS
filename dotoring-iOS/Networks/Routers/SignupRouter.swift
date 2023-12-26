//
//  SignupRouter.swift
//  dotoring-iOS
//
//  Created by 우진 on 12/21/23.
//

import Foundation
import Alamofire

// Signup API Router
enum SignupRouter: URLRequestConvertible {
    
    case fields
    case majors
    case validMentoNickname(nickname: String)
    case validMentiNickname(nickname: String)
    case validId(loginId: String)
    
    var baseURL: URL {
        return URL(string: API.BASE_URL + "api")!
    }

    var method: HTTPMethod {
        switch self {
        case .fields, .majors:
            return .get
        case .validMentoNickname, .validMentiNickname, .validId:
            return .post
        }
    }

    var endPoint: String {
        switch self {
        case .fields:
            return "fields"
        case .majors:
            return "majors"
        case .validMentoNickname:
            return "mento/valid-nickname"
        case .validMentiNickname:
            return "menti/valid-nickname"
        case .validId:
            return "member/valid-loginId"
        }
    }
    
    var parameters : [String: String] {
        switch self {
        case let .validMentoNickname(nickname), let .validMentiNickname(nickname):
            return ["nickname" : nickname]
        case let .validId(loginId):
            return ["loginId" : loginId]
        default:
            return [:]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        // 실제 api가 호출 되면서 발동 되는 부분
        
        let url = baseURL.appendingPathComponent(endPoint)
        
        print("SignupRouter - asURLRequest() url : \(url)")
        
        var request = URLRequest(url: url)
        request.method = method

        switch self {
        case .validMentoNickname, .validMentiNickname, .validId:
            request.httpBody = try JSONEncoder().encode(parameters)
        default:
            break
        }

        return request
    }
}
