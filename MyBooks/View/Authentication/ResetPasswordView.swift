//
//  ResetPasswordView.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/25.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @State private var showAlert = false
    @EnvironmentObject var authViewModel:AuthViewModel
    @Environment (\.dismiss) var dismiss
    @Binding private var email: String
    
    private var buttonIsDisabled:Bool {
        return email.isEmpty
    }
    
    init(email: Binding<String>) {
        self._email = email
    }
    
    var body: some View {
        VStack(spacing: 20) {
            CustomTextField(imageName: "envelope", placeholderText: "e-mail", isSecureField: false, text: $email)
            
            Button(action: {
                authViewModel.resetPassword(withEmail: email)
            }) {
                Text("パスワードリセットのリンクを送信")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .frame(width:UIScreen.main.bounds.width - 32,height: 50)
            .disabled(buttonIsDisabled)
            .background(buttonIsDisabled ? Color.gray : Color.cyan)
            .cornerRadius(20)
            .padding(.top, 20)
            .shadow(color: .gray, radius: 5)
            .shadow(color: .gray, radius: 5)
            
            Button(action: { dismiss() }, label: {
                HStack {
                    Text("すでにアカウントをお持ちの方はこちら")
                        .font(.system(size: 14))
                    
                    Text("Sign In")
                        .font(.system(size: 14, weight: .semibold))
                }.foregroundColor(.blue)
            })
        }
        .onReceive(authViewModel.$didSendResetPasswordLink) { _ in
            self.dismiss()
        }
    }
}

