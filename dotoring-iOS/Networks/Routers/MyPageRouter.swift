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
    case editMentoMentoringSys(text: String)
    case editMentiMentoringSys(text: String)
    case editMentoTags(tags: [String])
    case editMentiTags(tags: [String])
    case editMentoInfo(data: SignupData)
    case editMentiInfo(data: SignupData)
    
    var baseURL: URL {
        return URL(string: API.BASE_URL + "api")!
    }

    var method: HTTPMethod {
        switch self {
        case .mentoMyPage, .mentiMyPage:
            return .get
        case .editMentoMentoringSys, .editMentiMentoringSys, .editMentoTags, .editMentiTags:
            return .patch
        case .editMentoInfo, .editMentiInfo:
            return .put
        }
    }

    var endPoint: String {
        switch self {
        case .mentoMyPage, .editMentoInfo:
            return "mento/my-page"
        case .mentiMyPage, .editMentiInfo:
            return "menti/my-page"
        case .editMentoMentoringSys:
            return "mento/mentoring-system"
        case .editMentiMentoringSys:
            return "menti/preferred-mentoring"
        case .editMentoTags:
            return "mento/tags"
        case .editMentiTags:
            return "menti/tags"
        }
    }
    
    var parameters: [String: AnyEncodable] {
        switch self {
        case let .editMentoMentoringSys(text):
            return ["mentoringSystem": AnyEncodable(text)]
        case let .editMentiMentoringSys(text):
            return ["preferredMentoringSystem": AnyEncodable(text)]
        case let .editMentoTags(tags):
            return ["tags": AnyEncodable(tags)]
        case let .editMentiTags(tags):
            return ["tags": AnyEncodable(tags)]
        default:
            return [:]
        }
    }
    
    var multipartFormData: MultipartFormData {
        let multipartFormData = MultipartFormData()
        switch self {
        case let .editMentoInfo(data), let .editMentiInfo(data):
            multipartFormData.append(data.certificationsFileURL!, withName: "certifications")
            multipartFormData.append(Data(data.school!.utf8), withName: "school")
            multipartFormData.append(Data(String(data.grade!).utf8), withName: "grade")
            multipartFormData.append(Data(data.majors!.joined(separator: ",").utf8), withName: "majors")
            multipartFormData.append(Data(data.fields!.joined(separator: ",").utf8), withName: "fields")
            multipartFormData.append(Data(data.tags!.joined(separator: ",").utf8), withName: "tags")
        default: ()
        }

        return multipartFormData
    }

    func asURLRequest() throws -> URLRequest {
        // 실제 api가 호출 되면서 발동 되는 부분
        
        let url = baseURL.appendingPathComponent(endPoint)
        
        print("MyPageRouter - asURLRequest() url : \(url)")
        
        var request = URLRequest(url: url)
        request.method = method

        switch self {
        case .editMentoMentoringSys, .editMentiMentoringSys, .editMentoTags, .editMentiTags:
            request.httpBody = try JSONEncoder().encode(parameters)
        default:
            break
        }
        return request
    }
}

struct AnyEncodable: Encodable {
    private let value: Encodable

    init(_ value: Encodable) {
        self.value = value
    }

    func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}
