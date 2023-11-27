//
//  LoginModel.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/9/23.
//

import Foundation

struct ErrorData: Codable {
    let message: String
    let code: String?
    let status: Int
}

struct ErrorData2: Codable {
    let message: String
    let code: String?
    let status: String
}

struct LoginAPIResponse: Codable {
    let success: Bool
//    let response: String
    let error: ErrorData?
}

struct ReIssueAPIResponse: Codable {
    let success: Bool
    let error: ErrorData2?
}
