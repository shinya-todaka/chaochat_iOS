//
//  RoomDescriptionView.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/26.
//

import SwiftUI

struct RoomDescriptionView: View {
    
    let images = (1...8).map { "venom-\($0)" }

    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var viewModel: SingleRoomViewModel
    
    @State var isPresentProfileView = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack(alignment: .center, spacing: 32) {
                    Spacer()
                    Text("Among Us募集")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    HStack {
                        ForEach(images.suffix(4), id: \.self) { imageName in
                            Image(imageName)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .scaledToFit()
                        }
                        Button {
                            print("show members")
                        } label: {
                            Text("+16")
                                .foregroundColor(Color.black)
                                .frame(width: 40, height: 40)
                                .overlay(Circle().stroke(Color(UIColor.theme), lineWidth: 4))
                            }
                    }
                    
                    Button(action: {
                        isPresentProfileView = true
                    }, label: {
                        Text("参加")
                            .foregroundColor(Color.black)
                            .frame(width: proxy.size.width - 32, height: 50)
                            .background(Color(UIColor.theme))
                            .cornerRadius(8)
                            .padding()
                    })
                }
                
                FloatingButton(horizontal: .leading(16), vertical: .top(16)) {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .frame(width: 50, height: 50)
                        .background(Color(UIColor.theme))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
            }
        }
        .fullScreenCover(isPresented: $isPresentProfileView) {
            ProfileView(viewModel: viewModel)
        }
    }
}

struct RoomDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        RoomDescriptionView(viewModel: SingleRoomViewModel(roomID: "roomID"))
    }
}
