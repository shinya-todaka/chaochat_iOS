//
//  KeyboardAwareModifier.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/22.
//

import Combine
import SwiftUI

struct KeyboardAwareModifier: ViewModifier {
    
    @State private var keyboardHeight: CGFloat = 0
    let onChangeKeyboardHeightWithAnimation: ((CGFloat) -> Void)?
    
    init(_ onChangeKeyboardHeightWithAnimation: ((CGFloat) -> Void)?) {
        self.onChangeKeyboardHeightWithAnimation = onChangeKeyboardHeightWithAnimation
    }

    private var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
                .map { $0.cgRectValue.height },
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in CGFloat(0) }
       ).eraseToAnyPublisher()
    }

    public func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onReceive(keyboardHeightPublisher) { height in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    withAnimation {
                        onChangeKeyboardHeightWithAnimation?(height)
                    }
            })
        }
    }
}
