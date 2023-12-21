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
    
    case majors
    
    var baseURL: URL {
        return URL(string: API.BASE_URL + "api")!
    }

    var method: HTTPMethod {
        switch self {
        case .majors:
            return .get
        }
    }

    var endPoint: String {
        switch self {
        case .majors:
            return "majors"
        
        }
    }
    
    var parameters : [String: Int] {
        switch self {
            
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
        default: break
        }

        return request
    }
}
