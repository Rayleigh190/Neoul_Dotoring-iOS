//
//  UserDetailModel.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/15/23.
//

import Foundation

struct UserDetailInfo: Codable {
    let mentiId: Int?
    let mentoId: Int?
    let profileImage: String
    let nickname: String
    let preferredMentoring: String? // 멘티
    let mentoringSystem: String? // 멘토
    let fields: [String]
    let majors: [String]
    let introduction: String
    let grade: Int
}

struct UserDetailAPIResponse: Codable {
    let success: Bool
    let response: UserDetailInfo
    let error: ErrorData2?
}
