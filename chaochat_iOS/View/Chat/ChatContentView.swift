//
//  ChatContentView.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/23.
//

import SwiftUI

struct ChatContentView: View {
    
    let messages: [Document<Message>]
    let myUserID: String
    
    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView {
                LazyVStack {
                    ForEach(messages) { message in
                        MessageView(message: message, isMyMessage: message.data.from == myUserID)
                    }
                }
            }.modifier(KeyboardAwareModifier({ height in
                if let lastMessageId = messages.last?.id {
                    scrollViewProxy.scrollTo(lastMessageId)
                }
            })).padding(EdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4))
        }
    }
}
