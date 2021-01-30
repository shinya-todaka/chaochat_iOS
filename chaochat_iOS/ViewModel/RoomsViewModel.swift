//
//  RoomsViewModel.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/23.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase
import SwiftUI

class RoomsViewModel: ObservableObject {
    @Published var rooms: [Document<Room>] = []
    
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    let myUserID: String
    
    init(myUserID: String) {
        self.myUserID = myUserID
    }
    
    func fetchData() {
        let query = db.collection("message").document("v1").collection("rooms").whereField("members", arrayContains: myUserID)
        self.listener = query.addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let snapshot = snapshot {
                self.rooms = snapshot.documents.compactMap { document -> Document<Room>? in
                    try? Document(document: document)
                }
            }
        }
    }
    
    func createRoom(roomName: String, expiresIn: Room.ExpiresIn) {
        let roomRef = db.collection("message").document("v1").collection("rooms").document()
        let memberRef = roomRef.collection("members").document(myUserID)
        
        let room = Room(name: roomName, expiresIn: expiresIn, isClosed: false, members: [myUserID])
        let batch = Firestore.firestore().batch()
        do {
            
            let roomData = try Firestore.Encoder().encode(room)
            
            batch.setData(roomData, forDocument: roomRef)
            batch.setData([:], forDocument: memberRef)
            batch.commit { (error) in
                if let error = error {
                    print(error)
                    return
                }
                print("success create room")
            }
        } catch let error {
            print(error)
        }
    }
    
    deinit {
        listener?.remove()
    }
}
