//
//  Channel.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/25/23.
//

import Foundation

struct Channel {
    var id: String
    let name: String
    let major: String
    let lastLetter: String
    let updateAt: String
    
    init(id: String, name: String, major: String, lastLetter: String, updateAt: String) {
        self.id = id
        self.name = name
        self.major = major
        self.lastLetter = lastLetter
        self.updateAt = updateAt
    }
}

extension Channel: Comparable {
    static func == (lhs: Channel, rhs: Channel) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Channel, rhs: Channel) -> Bool {
        return lhs.name < rhs.name
    }
}
