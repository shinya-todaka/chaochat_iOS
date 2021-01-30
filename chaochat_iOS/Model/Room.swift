//
//  Room.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/23.
//

import Firebase
import FirebaseFirestoreSwift

struct Room: Codable {
    let name: String
    let expiresIn: ExpiresIn
    let isClosed: Bool
    let members: [String]
    @ServerTimestamp var createdAt: Timestamp?
    @ServerTimestamp var updatedAt: Timestamp?
    
    enum ExpiresIn: Int, Codable, CaseIterable {
        case _3 = 3
        case _5 = 5
        case _10 = 10
        case _15 = 15
    }
}
