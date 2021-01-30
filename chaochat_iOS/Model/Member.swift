//
//  Member.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/27.
//

import Firebase
import FirebaseFirestoreSwift

struct Member: Codable {
    let displayName: String
    var photoURL: String?
    var isEnabled: Bool
    @ServerTimestamp var createdAt: Timestamp?
}
