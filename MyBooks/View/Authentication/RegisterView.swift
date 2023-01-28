//
//  RegisterView.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/25.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userName = ""
    @State private var fullName = ""
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var authViewModel:AuthViewModel
    
    var body: some View {
            VStack {
                
                NavigationLink(
                    destination: ProfileImageSelectorView(),
                    isActive: $authViewModel.didAuthenticationUser,
                    label: {})
                
                VStack(spacing: 40) {
                    CustomTextField(imageName: "envelope", placeholderText: "e-mail", isSecureField: false, text: $email)
                    
                    CustomTextField(imageName: "lock", placeholderText: "password", isSecureField: true, text: $password)
                    
                    CustomTextField(imageName: "person", placeholderText: "usrName", isSecureField: false, text: $userName)
                    
                    CustomTextField(imageName: "person", placeholderText: "fullName", isSecureField: false, text: $fullName)
                }
                
                Button(action: {
                    //AuthViewModel.sharedでアクセスしても画面遷移できない(インスタンス化したものにアクセスする)
                    authViewModel.register(withEmail: email, fullname: fullName, userName: userName, password: password)
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340,height: 50)
                        .background(.cyan)
                        .cornerRadius(20)
                }
                .padding(.top, 20)
                .shadow(color: .gray, radius: 5)
                
                Button(action: {dismiss()}) {
                    HStack{
                        Text("アカウントをすでにお持ちの方はコチラ")
                            .font(.system(size: 14))
                        Text("Sign In")
                            .font(.system(size: 14,weight: .bold))
                    }
                }
                .padding(.top, 20)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
