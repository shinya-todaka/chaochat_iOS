//
//  ChatView.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/21.
//

import SwiftUI
import Combine

struct ChatView: View {
    
    @ObservedObject var messagesViewModel: MessagesViewModel
    
    init(messagesViewModel: MessagesViewModel) {
        self.messagesViewModel = messagesViewModel
    }
    
    @State var text: String = ""
    
    var body: some View {
        VStack {
            ChatContentView(messages: messagesViewModel.messages, myUserID: messagesViewModel.myUserID)
            InputView(text: $text) {
                messagesViewModel.sendMessage(text: text)
            }
        }.onAppear(perform: {
            messagesViewModel.fetchData()
        })
    }
}
