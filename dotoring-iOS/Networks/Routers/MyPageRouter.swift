//
//  MyPageRouter.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/29/24.
//

import Foundation
import Alamofire

// MyPage API Router
enum MyPageRouter: URLRequestConvertible {
    
    case mentoMyPage
    case mentiMyPage
    
    var baseURL: URL {
        return URL(string: API.BASE_URL + "api")!
    }

    var method: HTTPMethod {
        switch self {
        case .mentoMyPage, .mentiMyPage:
            return .get
        }
    }

    var endPoint: String {
        switch self {
        case .mentoMyPage:
            return "mento/my-page"
        case .mentiMyPage:
            return "menti/my-page"
        }
    }
    
    var parameters : Parameters {
        switch self {
        default:
            return [:]
        }
    }

    func asURLRequest() throws -> URLRequest {
        // 실제 api가 호출 되면서 발동 되는 부분
        
        let url = baseURL.appendingPathComponent(endPoint)
        
        print("MyPageRouter - asURLRequest() url : \(url)")
        
        var request = URLRequest(url: url)
        request.method = method

        switch self {
        default:
            break
        }
        return request
    }
}
