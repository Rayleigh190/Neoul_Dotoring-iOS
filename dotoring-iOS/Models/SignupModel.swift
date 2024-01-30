//
//  SignupModel.swift
//  dotoring-iOS
//
//  Created by 우진 on 12/21/23.
//

import Foundation

struct SignupData {
    var school: String?
    var grade: Int?
    var fields: [String]?
    var majors: [String]?
    var certificationsFileURL: URL?
    var nickname: String?
    var tags: [String]?
    var isDoc = false
}

struct Fields: Codable {
    let fields: [String]
}

struct Majors: Codable {
    let majors: [String]
}

struct FieldsAPIResponse: Codable {
    let success: Bool
    let response: Fields
    let error: ErrorData2?
}

struct MajorsAPIResponse: Codable {
    let success: Bool
    let response: Majors
    let error: ErrorData2?
}

struct ValidAPIResponse: Codable {
    let success: Bool
    let error: ErrorData2?
}
