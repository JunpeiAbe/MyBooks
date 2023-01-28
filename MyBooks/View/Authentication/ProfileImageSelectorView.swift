//
//  ProfileImageSelectorView.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/25.
//

import SwiftUI

struct ProfileImageSelectorView: View {
    
    @State private var showAlert = false
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileimage: Image?
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack{
            if authViewModel.isLoading{
                LoadingIndicator().zIndex(1.0)
            }
            VStack {
                Button(action: {
                    showImagePicker.toggle()
                    
                }) {
                    if let profileimage = profileimage {
                        profileimage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180,height: 180)
                            .clipShape(Circle())
                    }else{
                        Image(systemName: "photo.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width:180, height: 180)
                            .foregroundColor(.gray)
                    }
                    
                }
                .sheet(isPresented: $showImagePicker,onDismiss: loadImage) {
                    ImagePicker(image: $selectedImage)
                }
                
                Text("プロフィール画像を選択してください↑")
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.top, 20)
                
                Button(action: {
                    if let selectedImage = selectedImage {
                        authViewModel.uploadProfileImage(selectedImage)
                    }
                }) {
                    Text("画像の登録")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(.cyan)
                        .cornerRadius(20)
                }
                .shadow(color: .gray, radius: 5)
                .padding(.top, 20)
                Spacer()
            }
            .navigationBarBackButtonHidden()
            .padding(.top,50)
        }
        .onReceive(authViewModel.$errorMessage, perform: {errorMessage in
            if errorMessage != nil {
                self.showAlert.toggle()
            }
        })
        .alert(Text(authViewModel.errorMessage ?? "エラー"), isPresented: $showAlert) {
            Button("OK"){
                authViewModel.errorMessage = nil
            }
        }
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else {return}
        profileimage = Image(uiImage: selectedImage)
    }
}

struct ProfileImageSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageSelectorView()
    }
}
