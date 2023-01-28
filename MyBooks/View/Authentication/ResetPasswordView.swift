//
//  ResetPasswordView.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/25.
//

import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var authViewModel:AuthViewModel
    @Environment (\.dismiss) var dismiss
    @Binding private var email: String
    
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
                                .frame(width: 340,height: 50)
                                .background(.cyan)
                                .cornerRadius(20)
                        }
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

//struct ResetPasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResetPasswordView()
//    }
//}
