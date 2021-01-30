//
//  Document.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/23.
//

import Firebase

enum InitializationError: Error {
    case dataIsNull
}

struct Document<Data: Codable>: Identifiable {
    var id: String
    var data: Data
    
    init(id: String, data: Data) {
        self.id = id
        self.data = data
    }
    
    init(document: DocumentSnapshot) throws {
        self.id = document.documentID
        guard let data = try? document.data(as: Data.self) else {
            throw InitializationError.dataIsNull
        }
        self.data = data
    }
    
    static func mockMessages() -> [Document<Message>] {
        return [.init(id: "1", data: .init(createdAt: nil, from: "shinya todaka", text: "What is up ?")), .init(id: "2", data: .init(createdAt: nil, from: "shinya todaka", text: "Make it possible with panasonic")), .init(id: "3", data: .init(createdAt: nil, from: "shinya todaka", text: "Swift is a general-purpose, multi-paradigm, compiled programming language developed by Apple Inc. ")), .init(id: "4", data: .init(createdAt: nil, from: "shinya todaka", text: "Swift supports the concept of protocol extensibility, an extensibility system that can be applied to types, structs and classes, which Apple promotes as a real change in programming paradigms they term protocol-oriented programming"))]
    }
    
    static func mockRooms() -> [Document<Room>] {
        return [.init(id: "1", data: .init(name: "shinyaの部屋", expiresIn: ._3, isClosed: false, members: [])),.init(id: "2", data: .init(name: "hiroの部屋", expiresIn: ._5, isClosed: false, members: [])), .init(id: "3", data: .init(name: "satoruの部屋", expiresIn: ._10, isClosed: false, members: [])), .init(id: "4", data: .init(name: "yuichiの部屋", expiresIn: ._15, isClosed: false, members: []))]
    }
 }
