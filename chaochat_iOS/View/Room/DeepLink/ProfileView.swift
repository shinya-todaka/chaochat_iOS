//
//  ProfileView.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/27.
//

import SwiftUI
import Nuke
import Firebase

struct ProfileView: View {
    @State var name: String = ""
    @State var profileImage: UIImage?
    @State var isAbleToCommit: Bool = false
    @State var isShowPhotoLibrary = false
    @State var provider: AuthenticationService.Provider?
    
    @ObservedObject var viewModel: SingleRoomViewModel
    @EnvironmentObject var authService: AuthenticationService
    
    private let pipeline = ImagePipeline()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 32) {
                (profileImage.map { Image(uiImage: $0) } ?? Image(systemName: "person"))
                        .resizable()
                        .frame(width: 100, height: 100)
                        .background(Color(UIColor.theme))
                        .cornerRadius(8)
                        .onTapGesture(perform: {
                            self.isShowPhotoLibrary = true
                        })
                        
                    TextField("名前を決めてください", text: $name)
                        .padding([.leading, .trailing], 12)
                        .frame(height: 55)
                        .textFieldStyle(PlainTextFieldStyle())
                        .background(Color(UIColor.whitesmoke))
                        .cornerRadius(16)
                        .padding([.leading, .trailing], 12)
                
                    Button(action: {
                        if let uid = authService.user?.uid {
                            if provider == .twitter {
                                if let displayName = authService.user?.displayName, let photoURL = authService.user?.photoURL {
                                    let member = Member(displayName: displayName, photoURL: photoURL.absoluteString, isEnabled: true)
                                    viewModel.joinRoom(myUserID: uid, member: member)
                                }
                            }
                        }
                       
                    }, label: {
                        Text("決定")
                            .frame(width: 180, height: 46)
                            .foregroundColor(.white)
                            .background(Color(validateName(text: name) ? UIColor.theme : UIColor.thinTheme))
                            .cornerRadius(8)
                    }).disabled(!validateName(text: name))
                
                    if authService.providers.contains(.twitter) {
                        Button(action: {
                            guard let displayName = authService.user?.displayName,
                                  let profileImageURL = authService.user?.photoURL else {
                                return
                            }
                            
                            pipeline.loadImage(with: profileImageURL) { (result) in
                                switch result {
                                case let .failure(error):
                                    print(error)
                                case let .success(imageResponse):
                                    self.profileImage = imageResponse.image
                                }
                            }
                            
                            self.name = displayName
                            self.provider = .twitter
                        }, label: {
                            Text("ツイッターのプロフィールを使う")
                                .frame(width: 180, height: 46)
                                .foregroundColor(.white)
                                .background(Color(UIColor.theme))
                                .cornerRadius(8)
                        })
                    }
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

        }.sheet(isPresented: $isShowPhotoLibrary, content: {
            ImagePickerView(sourceType: .photoLibrary, selectedImage: self.$profileImage)
        })
    }
    
    private func validateName(text: String) -> Bool {
        return text.count > 0 && text.count < 30
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: SingleRoomViewModel(roomID: "room1"))
    }
}

