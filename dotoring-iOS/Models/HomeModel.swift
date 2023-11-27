//
//  HomeModel.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/13/23.
//

import Foundation

struct HomeUser: Codable {
    let id: Int
    let profileImage: String
    let nickname: String
    let preferredMentoringSystem: String?
    let mentoringSystem: String?
    let fields: [String]
    let majors: [String]
    let introduction: String
}

struct HomePageable: Codable {
    let nickname: String
}

struct HomeUserList: Codable {
    let content: [HomeUser]
    let pageable: HomePageable
    let first: Bool
    let last: Bool
}

struct HomeUserAPIResponse: Codable {
    let success: Bool
    let response: HomeUserList?
    let error: ErrorData2?
}
