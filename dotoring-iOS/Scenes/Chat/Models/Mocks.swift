//
//  Mocks.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/25/23.
//

import Foundation

func getChannelMocks() -> [Channel] {
    return (0...3).map { Channel(id: String($0), name: "닉네임 " + String($0)) }
}

func getMessagesMock() -> [Message] {
    return (0...3).map { Message(content: "message content \($0)", senderID: "0") }
}
