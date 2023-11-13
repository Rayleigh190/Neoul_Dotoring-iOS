//
//  HomeRouter.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/12/23.
//

import Foundation
import Alamofire

// Home API Router
enum HomeRouter: URLRequestConvertible {
    
    case menti(size: Int)
    case mento(size: Int)

    var baseURL: URL {
        return URL(string: API.BASE_URL + "api")!
    }

    var method: HTTPMethod {
        switch self {
        case .menti, .mento:
            return .get
        }
    }

    var endPoint: String {
        switch self {
        case .menti:
            return "menti"
        case .mento:
            return "mento"
        }
    }
    
    var parameters : [String: Int] {
        switch self {
        case let .menti(size), let .mento(size):
         return ["size" : size]
        }
    }

    func asURLRequest() throws -> URLRequest {
        // 실제 api가 호출 되면서 발동 되는 부분
        
        let url = baseURL.appendingPathComponent(endPoint)
        
        print("HomeRouter - asURLRequest() url : \(url)")
        
        var request = URLRequest(url: url)
        request.method = method

        switch self {
        case .menti, .mento:
            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        }

        return request
    }
}
