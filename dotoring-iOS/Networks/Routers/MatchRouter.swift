//
//  MatchRouter.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/26/24.
//

import Foundation
import Alamofire

// Home API Router
enum MatchRouter: URLRequestConvertible {
    
    case notification(goal: String, title: String, isClose: Bool)
    
    var baseURL: URL {
        return URL(string: API.BASE_URL + "api")!
    }

    var method: HTTPMethod {
        switch self {
        case .notification:
            return .get
        }
    }

    var endPoint: String {
        switch self {
        case .notification:
            return "notification"
        }
    }
    
    var parameters : Dictionary<String, AnyCodable>  {
        switch self {
        case let .notification(goal, title, isClose):
            return ["goal" : AnyCodable(goal), "title" : AnyCodable(title), "isClose" : AnyCodable(isClose)]
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
            request.httpBody = try JSONEncoder().encode(parameters)
        default: break
        }

        return request
    }
}

struct AnyCodable: Encodable {
    private let value: Encodable

    init(_ value: Encodable) {
        self.value = value
    }

    func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}
