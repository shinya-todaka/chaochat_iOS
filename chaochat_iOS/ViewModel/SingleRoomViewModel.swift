//
//  RoomDescriptionViewModel.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/27.
//

import SwiftUI
import Firebase

class SingleRoomViewModel: ObservableObject {
    
    @Published var room: Room?
    private var db = Firestore.firestore()
    let roomID: String
    
    init(roomID: String) {
        self.roomID = roomID
    }
    
    func fetchData() {
        let query = db.collection("message").document("v1").collection("rooms").document(roomID)
        query.getDocument { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            
            do {
                let room = try snapshot?.data(as: Room.self)
                self.room = room
            } catch let error {
                print(error)
            }
        }
    }
    
    func joinRoom(myUserID: String, member: Member) {
        let roomRefernece = db.collection("message").document("v1").collection("rooms").document(roomID)
        let memberReference = roomRefernece.collection("members").document(myUserID)
        let batch = db.batch()
        
        do {
            batch.updateData(["members": FieldValue.arrayUnion([myUserID]), "updatedAt": FieldValue.serverTimestamp()], forDocument: roomRefernece)
            try batch.setData(from: member, forDocument: memberReference, encoder: Firestore.Encoder())
        } catch let error {
            print(error)
            return
        }
        
        batch.commit { (error) in
            if let error = error {
                print(error)
                return
            }
            print("joined room!")
        }
    }
}
