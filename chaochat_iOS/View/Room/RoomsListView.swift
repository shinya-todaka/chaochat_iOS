//
//  RoomsView.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/23.
//

import SwiftUI

struct RoomsListView: View {
    
    @EnvironmentObject var authService: AuthenticationService
    @EnvironmentObject var screenCoordinator: ScreenCoordinator
    @ObservedObject var roomsViewModel: RoomsViewModel
    @State private var isOpenCreateRoomView: Bool = false
    
    init(roomsViewModel: RoomsViewModel) {
        self.roomsViewModel = roomsViewModel
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(roomsViewModel.rooms) { room in
                    let messagesViewModel = MessagesViewModel(myUserID: roomsViewModel.myUserID, roomID: room.id)
                    let chatView = ChatView(messagesViewModel: messagesViewModel)
                    NavigationLink(destination: chatView) {
                        RoomView(room: room)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("chaochat")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.red)
            .navigationBarItems(leading: Button("signout", action: {
                self.authService.signout()
            }), trailing: Button("create", action: {
                self.isOpenCreateRoomView.toggle()
            }))
            .sheet(isPresented: $isOpenCreateRoomView) {
                CreateRoomView(onCommit:  { roomName, expiresIn in
                    roomsViewModel.createRoom(roomName: roomName, expiresIn: expiresIn)
                })
            }
            .fullScreenCover(isPresented: $screenCoordinator.room.isPresented , content: {
                if let roomID = screenCoordinator.room.item {
                    let viewModel = SingleRoomViewModel(roomID: roomID)
                    RoomDescriptionView(viewModel: viewModel)
                }
            })
            .onAppear(perform: { () in
                roomsViewModel.fetchData()
            })
        }
    }
}
