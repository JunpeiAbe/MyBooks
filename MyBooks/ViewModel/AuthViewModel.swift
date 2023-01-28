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
    @Published var errorMessage:String?
    @Published var isLoading = false
    
    private var tempCurrentUser:FirebaseAuth.User?
    
    init() {
        
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
        
    }
    
    func login(withEmail email:String, password:String) {
        
        isLoading = true
        
        Auth.auth().signIn(withEmail: email, password: password) { result,error in
            if error != nil {
                self.isLoading = false
                self.errorMessage = self.authErrorMessage(of: error!)
                return
            }
            guard let user = result?.user else {
                self.isLoading = false
                return
            }
            self.userSession = user
            self.fetchUser()
        }
    }
    
    
    func register(withEmail email:String, fullname:String, userName:String,password:String) {
        
        isLoading = true
        
        Auth.auth().createUser(withEmail: email, password: password){ result,error in
            if error != nil {
                self.isLoading = false
                self.errorMessage = self.authErrorMessage(of: error!)
                return
            }
            
            guard let user = result?.user else {
                self.isLoading = false
                return
            }
            self.tempCurrentUser = user
            
            let data: [String: Any] = ["email":email,"userName":userName,"fullName":fullname]
            
            COLLECTION_USER.document(user.uid).setData(data){_ in
                
                self.didAuthenticationUser = true
                self.isLoading = false
            }
        }
    }
    
    func uploadProfileImage(_ image: UIImage) {
        
        isLoading = true
        
        guard let uid = tempCurrentUser?.uid else {
            return
        }
        ImageUploader.uploadImage(image: image) { imageUrl in
            COLLECTION_USER.document(uid).updateData(["profileImageURL":imageUrl]){ _ in
                self.userSession = self.tempCurrentUser
                self.fetchUser()
            }
        }
    }
    
    
    func fetchUser() {
        guard let uid = userSession?.uid else {return}
        
        COLLECTION_USER.document(uid).getDocument { snapshot, error in
            
            if error != nil {
                self.isLoading = false
                self.errorMessage = self.authErrorMessage(of: error!)
                return
            }
            
            guard let user = try? snapshot?.data(as: User.self) else {
                self.isLoading = false
                return
            }
            self.currentUser = user
            self.isLoading = false
           
        }
    }
    
    func resetPassword(withEmail email:String) {
        
        isLoading = true
        
        Auth.auth().sendPasswordReset(withEmail: email) {error in
            if error != nil {
                self.isLoading = false
                self.errorMessage = self.authErrorMessage(of: error!)
                return
            }
            self.isLoading = false
            self.didSendResetPasswordLink = true
        }
    }
    
    func signout() {
        do {
            self.isLoading = true
            userSession = nil
            try Auth.auth().signOut()
            
        }catch {
            self.errorMessage = self.authErrorMessage(of: error)
            self.isLoading = false
        }
        self.isLoading = false
    }
    
    func authErrorMessage(of error:Error) -> String{
        var message = ""
        guard let errorCode = AuthErrorCode.Code(rawValue: error._code) else {
            return message
        }
        switch errorCode {
        case .networkError: message = AuthError.networkError.message
        case .weakPassword: message = AuthError.weakPassword.message
        case .userNotFound: message = AuthError.userNotFound.message
        case .wrongPassword: message = AuthError.wrongPassword.message
        case .userDisabled: message = AuthError.userDisabled.message
        case .requiresRecentLogin: message = AuthError.requiresRecentLogin.message
        case .emailAlreadyInUse: message = AuthError.emailAlreadyInUse.message
        default: message = AuthError.unknown.message
        }
        return message
    }
}
