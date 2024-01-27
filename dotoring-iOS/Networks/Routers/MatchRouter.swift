//
//  MatchRouter.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/26/24.
//

import Foundation
import Alamofire

// Match API Router
enum MatchRouter: URLRequestConvertible {
    
    case notification(goal: String, title: String, isClose: Bool)
    
    var baseURL: URL {
        return URL(string: API.BASE_URL + "api")!
    }

    var method: HTTPMethod {
        switch self {
        case .notification:
            return .post
        }
    }

    var endPoint: String {
        switch self {
        case .notification:
            return "notification"
        }
    }
    
    var parameters : Parameters {
        switch self {
        case let .notification(goal, title, isClose):
            return ["goal": goal, "title": title, "isClose": isClose]
        default:
            return [:]
        }
    }

    func asURLRequest() throws -> URLRequest {
        // 실제 api가 호출 되면서 발동 되는 부분
        
        let url = baseURL.appendingPathComponent(endPoint)
        
        print("MatchRouter - asURLRequest() url : \(url)")
        
        var request = URLRequest(url: url)
        request.method = method

        switch self {
        case .notification:
            request = try URLEncoding.httpBody.encode(request, with: parameters)
        default:
            break
        }
        return request
    }
}
