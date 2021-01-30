//
//  AuthenticationService .swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/23.
//

import Combine
import Firebase
import FirebaseAuth

class AuthenticationService: ObservableObject {

    @Published var authState: AuthState = .pending
    
    var user: Firebase.User? {
        if case let .authenticated(user, _) = authState {
            return user
        }
        return nil
    }
    
    var providers: [Provider] {
        if case let .authenticated(_, providers) = authState {
            return providers
        }
        return []
    }
    
    enum AuthState {
        case authenticated(FirebaseAuth.User, [Provider])
        case notAuthenticated
        case pending
    }
    
    enum Provider: String{
        case twitter = "twitter.com"
        case apple = "apple.com"
    }
    
    private var twitterProvider: OAuthProvider?
    private var handle: AuthStateDidChangeListenerHandle?

    init() {
        self.handle = Auth.auth().addStateDidChangeListener { authResult, user in
            if let user = authResult.currentUser {
                print("current user is not nil")
                
                let providers = user.providerData.compactMap { Provider(rawValue: $0.providerID) }
                self.authState = .authenticated(user, providers)
            
                return
            }
            self.authState = .notAuthenticated
        }
    }

    func signIn() {
        Auth.auth().signInAnonymously()
    }
    
    func signInWithTwitter() {
        self.twitterProvider = OAuthProvider(providerID: "twitter.com")
        self.twitterProvider?.getCredentialWith(_: nil) { credential, error in
            if let error = error {
                print(error)
                return
            }
              if let credential = credential {
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        print(error)
                        return
                    }
                    print("success sign in with twitter")
                    let user = authResult?.user
                    if let photoURL = user?.photoURL {
                        print(photoURL)
                    }
                }
            }
        }
     }

    func signout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}
