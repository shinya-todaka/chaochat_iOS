//
//  SignInView.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/21.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        Button(action: {
            print("sign in!")
        }, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        })
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
