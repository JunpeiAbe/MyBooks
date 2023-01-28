//
//  ProfileImageSelectorView.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/25.
//

import SwiftUI

struct ProfileImageSelectorView: View {
    @State private var imagePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var profileimage: Image?
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Button(action: {imagePickerPresented.toggle()}) {
                
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
                
            }.sheet(isPresented: $imagePickerPresented,onDismiss: loadImage) {
                ImagePicker(image: $selectedImage)
            }
            
            Text("プロフィール画像を選択してください↑")
                .font(.system(size: 20, weight: .semibold))
                .padding(.top, 20)
            
            Button(action: {
                print("Continue")
                if let image = selectedImage {
                    authViewModel.uploadProfileImage(image)
                }
            }) {
                Text("Continue")
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
    
    func loadImage() {
        //選択した画像(selectedImage)をprofileImageに入れる
        //sheetが閉じる時に行う処理
        guard let selectedImage = selectedImage else {return}
        profileimage = Image(uiImage: selectedImage)
    }
}

struct ProfileImageSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageSelectorView()
    }
}
