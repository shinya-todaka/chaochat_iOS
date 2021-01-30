//
//  CreateRoomView.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/23.
//

import SwiftUI

struct CreateRoomView: View {
    @State var roomName: String = ""
    @State var roomExpiresIn: Room.ExpiresIn = ._3
    var onCommit: ((_ roomName: String, _ roomExpiresIn: Room.ExpiresIn) -> Void)?
    var body: some View {
        TextField("名前を入力してください", text: $roomName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
        Picker(selection: $roomExpiresIn, label: Text("ルームの制限時間を決めてください"), content: {
            ForEach(Room.ExpiresIn.allCases, id: \.self) { expiresIn in
                Text("\(expiresIn.rawValue)").tag(expiresIn)
            }
        }).padding()
        Button("作成") {
            onCommit?(roomName, roomExpiresIn)
        }
    }
}
