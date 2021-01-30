//
//  RootView.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/21.
//

import SwiftUI
import FirebaseAuth

struct RootView: View {
    
    @EnvironmentObject var authenticationService: AuthenticationService
    @EnvironmentObject var screenCoordinator: ScreenCoordinator
    
    var body: some View {
        Group {
            switch authenticationService.authState {
                case let .authenticated(user, providers):
                    RoomsListView(roomsViewModel: RoomsViewModel(myUserID: user.uid))
                case .notAuthenticated:
                    SignInView()
                case .pending:
                    ProgressView()
            }
        }.onOpenURL { (url) in
            if let deeplink = url.deeplink() {
                switch deeplink {
                case let .room(roomID: roomID):
                    screenCoordinator.room = .init(isPresented: true, item: roomID)
                }
            }
        }
    }
}

class ScreenCoordinator: ObservableObject {
    @Published var room: Screen<String> = Screen(isPresented: false, item: nil)
    
    struct Screen<T> {
        var isPresented: Bool
        var item: T?
    }
}
