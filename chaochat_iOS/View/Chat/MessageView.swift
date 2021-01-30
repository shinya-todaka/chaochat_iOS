//
//  MessageView.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/22.
//

import SwiftUI

struct MessageView: View {
    
    let message: Document<Message>
    let isMyMessage: Bool
    
    var body: some View {
        
        HStack {
            if isMyMessage {
                Spacer()
            }
            Text(message.data.text)
                .foregroundColor(.white)
                .padding()
                .background(Color(.systemPink))
                .cornerRadius(8)
                .padding(isMyMessage ? .leading : .trailing, 30)
                .padding(isMyMessage ? .trailing : .leading, 8)
            if !isMyMessage {
                Spacer()
            }
        }
    }
}
