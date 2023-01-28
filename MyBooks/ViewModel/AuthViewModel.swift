//
//  AuthViewModel.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/25.
//

import Firebase
import FirebaseFirestoreSwift
import SwiftUI

class AuthViewModel:ObservableObject{
    
    static let shared = AuthViewModel()
    
    @Published var didAuthenticationUser = false
    @Published var userSession:FirebaseAuth.User?
    @Published var currentUser:User?
    @Published var didSendResetPasswordLink = false
    
    private var tempCurrentUser:FirebaseAuth.User?
    
    init() {
        //初期値を持たせておかないと、アカウントがあってもuserSessionはnilとなり起動時に常にloginViewにいってしまう。
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
        //print("User is \(self.userSession)")
    }
    //ログイン
    func login(withEmail email:String, password:String) {
        Auth.auth().signIn(withEmail: email, password: password) { result,error in
            if error != nil {
                print("error is login")
                return
            }
            guard let user = result?.user else {return}
            self.userSession = user
            self.fetchUser()
        }
    }
    
    //ユーザ登録
    func register(withEmail email:String, fullname:String, userName:String,password:String) {
        Auth.auth().createUser(withEmail: email, password: password){ result,error in
            if error != nil {
                print("error is register")
                return
            }
            
            guard let user = result?.user else {return}
            self.tempCurrentUser = user
            
            let data: [String: Any] = ["email":email,"userName":userName,"fullName":fullname]
            
            COLLECTION_USER.document(user.uid).setData(data){_ in
                
                self.didAuthenticationUser = true
                
            }
        }
    }
    //プロフィール画像を登録
    func uploadProfileImage(_ image: UIImage) {
        //guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let uid = tempCurrentUser?.uid else {
            print("tempCurrentUser is Nil")
            return
        }
        ImageUploader.uploadImage(image: image) { imageUrl in
            COLLECTION_USER.document(uid).updateData(["profileImageURL":imageUrl])
            //self.userSession = Auth.auth().currentUser
            self.userSession = self.tempCurrentUser
            self.fetchUser()
        }
    }
    
    //ユーザー情報の取得
    func fetchUser() {
        guard let uid = userSession?.uid else {return}
        
        COLLECTION_USER.document(uid).getDocument { snapshot, error in
            
            if error != nil {
                print("error is fetchUser")
                return
            }
            
            //FiewbaseFireStoreSwiftを使ったパターン
            guard let user = try? snapshot?.data(as: User.self) else {return}
            self.currentUser = user
           
        }
    }
    
    func resetPassword(withEmail email:String) {
        Auth.auth().sendPasswordReset(withEmail: email) {error in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            self.didSendResetPasswordLink = true
            print("成功")
        }
    }
    
    //ログアウト
    func signout() {
        do {
            userSession = nil
            try Auth.auth().signOut()
        }catch {
            print(error)
        }
        
    }
}
