//
//  FloatingButton.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/30.
//

import UIKit
import SwiftUI

struct FloatingButton<Label: View>: View {
    
    enum H {
        case leading(_ padding: CGFloat)
        case trailing(_ padding: CGFloat)
    }
    
    enum V {
        case top(_ padding: CGFloat)
        case bottom(_ padding: CGFloat)
    }
    
    let horizontal: H
    let vertical: V
    let commit: (() -> Void)
    let label: (() -> Label)
    let edgeInsets: EdgeInsets
    
    init(horizontal: H, vertical: V, commit: @escaping (() -> Void), label: @escaping () -> Label) {
        self.horizontal = horizontal
        self.vertical = vertical
        self.commit = commit
        self.label = label
        
        switch (horizontal, vertical) {
        case let (.leading(leadingPadding), .top(topPadding)):
            edgeInsets = EdgeInsets(top: topPadding, leading: leadingPadding, bottom: 0, trailing: 0)
        case let (.leading(leadingPadding), .bottom(bottomPadding)):
            edgeInsets = EdgeInsets(top: 0, leading: leadingPadding, bottom: bottomPadding, trailing: 0)
        case let (.trailing(trailingPadding), .top(topPadding)):
            edgeInsets = EdgeInsets(top: topPadding, leading: 0, bottom: 0, trailing: trailingPadding)
        case let (.trailing(trailingPadding), .bottom(bottomPadding)):
            edgeInsets = EdgeInsets(top: 0, leading: 0, bottom: bottomPadding, trailing: trailingPadding)
        }
    }
    
    var body: some View {
        VStack {
            if case .bottom(_) = vertical {
                Spacer()
            }
            HStack {
                if case .trailing(_) = horizontal {
                    Spacer()
                }
                Button {
                    commit()
                } label: {
                    label()
                }.padding(edgeInsets)
                if case .leading(_) = horizontal {
                    Spacer()
                }
            }
            if case .top(_) = vertical {
                Spacer()
            }
        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton(horizontal: .leading(8), vertical: .top(16)) {
            print("commit")
        } label: {
            Text("close")
        }
    }
}
