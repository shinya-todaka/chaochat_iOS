//
//  Message.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/21.
//

import Firebase
import FirebaseFirestoreSwift

struct Message: Codable {
    @ServerTimestamp var createdAt: Timestamp?
    var from: String
    var text: String
    
    static func mockMessages() -> [Message] {
        return [.init(createdAt: nil, from: "shinya todaka", text: "what is up"), .init(createdAt: nil, from: "hiro todaka", text: "sup"), .init(createdAt: nil, from: "satoru todaka", text: "how are you ?"), .init(createdAt: nil, from: "yuichi todaka", text: "what is going on ?")]
    }
}
