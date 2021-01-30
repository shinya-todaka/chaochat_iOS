//
//  SignInView.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/21.
//

import SwiftUI
import FirebaseAuth
import AuthenticationServices

struct SignInWithAppleButtonInternal: UIViewRepresentable {
    let original: ASAuthorizationAppleIDButton
    
    init(_ original: ASAuthorizationAppleIDButton) {
        self.original = original
    }
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return original
    }
  
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
}

struct SignInView: View {
    
    @Environment(\.window) var window: UIWindow?
    @EnvironmentObject var authService: AuthenticationService
    @State var signInHandler: SignInWithAppleCoordinator?
    
    var body: some View {
        
        GeometryReader { proxy in
            VStack {
                Spacer()
                Button(action: {
                    authService.signInWithTwitter()
                }, label: {
                    Text("Sign in with Twitter")
                        .frame(width: proxy.size.width - 16, height: 40, alignment: .center)
                        .padding(8)
                        .background(Color(UIColor.twitter))
                        .foregroundColor(Color.white)
                        .cornerRadius(8)
                })
                SignInWithAppleButtonInternal(ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline))
                    .frame(width: proxy.size.width - 16, height: 40)
                    .onTapGesture {
                        signInWithAppleButtonTapped()
                    }
                Button(action: {
                    authService.signIn()
                }, label: {
                    Text("Sign in anonymously")
                        .frame(width: proxy.size.width - 16, height: 40, alignment: .center)
                        .padding(8)
                        .background(Color.pink)
                        .foregroundColor(Color.white)
                        .cornerRadius(8)
                })
            }
        }.padding(EdgeInsets(top: 0, leading: 16, bottom: 32, trailing: 16))
    }
    
    private func signInWithAppleButtonTapped() {
        signInHandler = SignInWithAppleCoordinator(window: self.window, authenticationService: self.authService)
        signInHandler?.signIn(onSignedInHandler: { (user) in
            print(user.displayName)
        })
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
