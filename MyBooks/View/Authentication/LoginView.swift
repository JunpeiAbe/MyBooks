//
//  LoginView.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    private var buttonIsDisabled:Bool {
        return email.isEmpty || password.isEmpty
    }
    @EnvironmentObject var authViewModel:AuthViewModel
    
    var body: some View {
        ZStack{
            if authViewModel.isLoading{
                LoadingIndicator().zIndex(1.0)
            }
            NavigationView {
                VStack {
                    VStack(spacing: 20) {
                        CustomTextField(imageName: "envelope", placeholderText: "e-mail", isSecureField: false, text: $email)
                        
                        CustomTextField(imageName: "lock", placeholderText: "password", isSecureField: false, text: $password)
                    }
                    
                    HStack {
                        Spacer()
                        NavigationLink(
                            destination: ResetPasswordView(email: $email).navigationTitle("パスワードのリセット").navigationBarBackButtonHidden(),
                            label: {
                                Text("パスワードを忘れた")
                                    .font(.system(size: 13, weight: .semibold))
                                    .padding(.top)
                                    .padding(.trailing, 28)
                            })
                    }
                    
                    Button(action: {
                        authViewModel.login(withEmail: email, password: password)}) {
                            Text("Sign In")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .frame(width:UIScreen.main.bounds.width - 32,height: 50)
                        .disabled(buttonIsDisabled)
                        .background(buttonIsDisabled ? Color.gray : Color.cyan)
                        .cornerRadius(20)
                        .padding(.top, 20)
                        .shadow(color: .gray, radius: 5)
                    
                    NavigationLink(
                        destination:{
                            RegisterView()
                                .navigationBarBackButtonHidden()
                        }) {
                            Text("アカウントをお持ちでない方はコチラ")
                                .font(.system(size: 14))
                            Text("Sign Up")
                                .font(.system(size: 14,weight: .bold))
                        }
                        .padding(.top, 20)
                }
                .navigationBarTitle("ログイン")
                .navigationBarTitleDisplayMode(.inline)
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
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
