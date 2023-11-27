//
//  Message.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/25/23.
//

import Foundation
import MessageKit
import UIKit

struct Message: MessageType {
    
//    let id: String
    let messageId: String
    let sender: SenderType
    let sentDate: Date
    var kind: MessageKind {
        if let image = image {
            let mediaItem = ImageMediaItem(image: image)
            return .photo(mediaItem)
        } else {
            return .text(content)
        }
    }
    let content: String
   
    var image: UIImage?
//    var downloadURL: URL?
    
    init(messageId: String, sender: SenderType, sentDate: Date, content: String) {
        self.messageId = messageId
        self.sender = sender
        self.sentDate = sentDate
        self.content = content
    }
    
//    init(image: UIImage) {
//        sender = Sender(senderId: "id(TODO...)", displayName: "displayName(TODO...)")
//        self.image = image
//        sentDate = Date()
//        content = ""
//        id = nil
//    }
    
}

extension Message: Comparable {
  static func == (lhs: Message, rhs: Message) -> Bool {
    return lhs.messageId == rhs.messageId
  }

  static func < (lhs: Message, rhs: Message) -> Bool {
    return lhs.sentDate < rhs.sentDate
  }
}
