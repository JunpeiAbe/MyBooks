//
//  EditProfileView.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/25.
//

import SwiftUI

struct EditProfileView: View {
    
    @State var bioText: String = ""
    @Environment(\.dismiss) var dismiss
    @ObservedObject var editProfileViewModel:EditProfileViewModel
    @Binding var user:User
    
    init(user: Binding<User>) {
        self._user = user
        self.editProfileViewModel = EditProfileViewModel(user: self._user.wrappedValue)
        self._bioText = State(initialValue: _user.wrappedValue.bio ?? "")
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Cancel")
                })
                
                Spacer()
                
                Button(action: {
                    editProfileViewModel.saveUserBio(bioText: bioText) {
                        self.user.bio = editProfileViewModel.user.bio
                        dismiss()
                    }
                }, label: {
                    Text("Done").bold()
                })
            }.padding()
            
            TextArea(text: $bioText, placeholder: "ひとこと")
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                .padding()
            
            Spacer()
        }
    }
}

