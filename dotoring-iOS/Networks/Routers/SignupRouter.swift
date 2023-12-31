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
    case validEmail(email: String)
    case validCode(email: String, code: String)
    case signupMento(certifications: URL, school: String, grade: String, majors: String, fields: String, nickname: String, introduction: String, loginId: String, password: String, email: String)
    case signupMenti(certifications: URL, school: String, grade: String, majors: String, fields: String, nickname: String, introduction: String, loginId: String, password: String, email: String)
    
    var baseURL: URL {
        return URL(string: API.BASE_URL + "api")!
    }

    var method: HTTPMethod {
        switch self {
        case .fields, .majors, .validEmail:
            return .get
        case .validMentoNickname, .validMentiNickname, .validId, .validCode, .signupMento, .signupMenti:
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
        case .validEmail:
            return "member/signup/code"
        case .validCode:
            return "member/signup/valid-code"
        case .signupMento:
            return "signup-mento"
        case .signupMenti:
            return "signup-menti"
        }
    }
    
    var parameters : [String: String] {
        switch self {
        case let .validMentoNickname(nickname), let .validMentiNickname(nickname):
            return ["nickname" : nickname]
        case let .validId(loginId):
            return ["loginId" : loginId]
        case let .validEmail(email):
            return ["email" : email]
        case let .validCode(email, code):
            return ["email": email, "emailVerificationCode": code]
        default:
            return [:]
        }
    }
    
    var multipartFormData: MultipartFormData {
        let multipartFormData = MultipartFormData()
        switch self {
        case let .signupMento(certifications, school, grade, majors, fields, nickname, introduction, loginId, password, email), let .signupMenti(certifications, school, grade, majors, fields, nickname, introduction, loginId, password, email):
            multipartFormData.append(certifications, withName: "certifications")
            multipartFormData.append(Data(school.utf8), withName: "school")
            multipartFormData.append(Data(grade.utf8), withName: "grade")
            multipartFormData.append(Data(majors.utf8), withName: "majors")
            multipartFormData.append(Data(fields.utf8), withName: "fields")
            multipartFormData.append(Data(nickname.utf8), withName: "nickname")
            multipartFormData.append(Data(introduction.utf8), withName: "introduction")
            multipartFormData.append(Data(loginId.utf8), withName: "loginId")
            multipartFormData.append(Data(password.utf8), withName: "password")
            multipartFormData.append(Data(email.utf8), withName: "email")
        default: ()
        }

        return multipartFormData
    }
    
    func asURLRequest() throws -> URLRequest {
        // 실제 api가 호출 되면서 발동 되는 부분
        
        let url = baseURL.appendingPathComponent(endPoint)
        
        print("SignupRouter - asURLRequest() url : \(url)")
        
        var request = URLRequest(url: url)
        request.method = method

        switch self {
        case .validMentoNickname, .validMentiNickname, .validId, .validCode:
            request.httpBody = try JSONEncoder().encode(parameters)
        case .validEmail:
            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        default:
            break
        }

        return request
    }
}
