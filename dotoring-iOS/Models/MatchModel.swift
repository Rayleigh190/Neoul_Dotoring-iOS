//
//  MatchModel.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/26/24.
//

import Foundation

struct MatchNoti: Codable {
    let id: Int
    let notificationName: String
    let writer: String
    let createAt: String
    let applicantsNum: Int
    let isClose: Bool
}

struct MatchNotiList: Codable {
    let notificationDTOS: [MatchNoti]
}

struct MatchNotiResponse: Codable {
    let success: Bool
    let response: MatchNotiList?
    let error: ErrorData2?
}
