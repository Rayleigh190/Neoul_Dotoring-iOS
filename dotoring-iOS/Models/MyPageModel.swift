//
//  MyPageModel.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/29/24.
//

import Foundation

struct MyPage: Codable {
    let mentoId: Int?
    let mentiId: Int?
    let profileImage: String
    let nickname: String
    let fields: [String]
    let majors: [String]
    let tags: [String]
    let grade: Int
    let mentoringSystem: String
    let school: String?
}

struct MyPageResponse: Codable {
    let success: Bool
    let response: MyPage
    let error: ErrorData2?
}
