//
//  SignupModel.swift
//  dotoring-iOS
//
//  Created by 우진 on 12/21/23.
//

import Foundation

struct Fields: Codable {
    let majors: [String]
}

struct MajorsAPIResponse: Codable {
    let success: Bool
    let response: Fields
    let error: ErrorData2?
}
