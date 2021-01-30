//
//  MessagesViewModel.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/22.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

class MessagesViewModel: ObservableObject {
    @Published var messages: [Document<Message>] = []
    
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    let myUserID: String
    let roomID: String
    
    init(myUserID: String, roomID: String) {
        self.myUserID = myUserID
        self.roomID = roomID
    }
    
    func fetchData() {
        let query = db.collection("message").document("v1").collection("rooms").document(roomID).collection("messages").order(by: "createdAt")
        self.listener = query.addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let snapshot = snapshot {
                self.messages = snapshot.documents.compactMap { document -> Document<Message>? in
                    try? Document(document: document)
                }
            }
        }
    }
    
    func sendMessage(text: String) {
        let roomReference = db.collection("message").document("v1").collection("rooms").document(roomID).collection("messages")
        let message = Message(from: myUserID, text: text)
        
        do {
            let data = try Firestore.Encoder().encode(message)
            roomReference.addDocument(data: data) { (error) in
                if let error = error {
                    print(error)
                    return
                }
                print("success!")
            }
        } catch let error {
            print(error)
        }
    }
    
    deinit {
        listener?.remove()
    }
}
