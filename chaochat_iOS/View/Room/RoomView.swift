//
//  RoomView.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/23.
//

import SwiftUI

struct RoomView: View {
    
    let room: Document<Room>
    
    var body: some View {
        Text(room.data.name)
    }
}
