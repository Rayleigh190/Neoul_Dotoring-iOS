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
    case mentiPage(size: Int, lastMentiId: Int)
    case mentoPage(size: Int, lastMentoId: Int)
    case mentiDetail(id: Int)
    case mentoDetail(id: Int)

    var baseURL: URL {
        return URL(string: API.BASE_URL + "api")!
    }

    var method: HTTPMethod {
        switch self {
        case .menti, .mento, .mentiDetail, .mentoDetail,
                .mentiPage, .mentoPage:
            return .get
        }
    }

    var endPoint: String {
        switch self {
        case .menti, .mentiPage:
            return "menti"
        case .mento, .mentoPage:
            return "mento"
        case let .mentiDetail(id):
            return "menti/\(id)"
        case let .mentoDetail(id):
            return "mento/\(id)"
        }
    }
    
    var parameters : [String: Int] {
        switch self {
        case let .menti(size), let .mento(size):
            return ["size" : size]
        case let .mentiPage(size, lastMentiId):
            return ["size" : size, "lastMentiId" : lastMentiId]
        case let .mentoPage(size, lastMentoId):
            return ["size" : size, "lastMentoId" : lastMentoId]
        default:
            return [:]
        }
    }

    func asURLRequest() throws -> URLRequest {
        // 실제 api가 호출 되면서 발동 되는 부분
        
        let url = baseURL.appendingPathComponent(endPoint)
        
        print("HomeRouter - asURLRequest() url : \(url)")
        
        var request = URLRequest(url: url)
        request.method = method

        switch self {
        case .menti, .mento, .mentiPage, .mentoPage:
            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        default: break
        }

        return request
    }
}
