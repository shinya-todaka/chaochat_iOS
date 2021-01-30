//
//  InputView.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/23.
//

import SwiftUI

struct InputView: View {
    
    @Binding var text: String
    let onCommit: (() -> Void)?
    
    var body: some View {
        HStack(alignment: .center, spacing: 8, content: {
            TextField("type message!", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                onCommit?()
            }, label: {
                Image(systemName: "paperplane")
            })
            .disabled(!isValidateText(text: text))
        }).padding()
    }
    
    private func isValidateText(text: String) -> Bool {
        return text.count > 0 && text.count < 100
    }
}
