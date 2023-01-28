//
//  ProfileViewModel.swift
//  MyBooks
//
//  Created by Junpei  on 2022/12/02.
//

import Foundation
import FirebaseFirestore


class ProfileViewModel:ObservableObject {
    
    @Published var user:User
    @Published var impressions = [Impressions]()
    @Published var userImpressions = [Impressions]()
    @Published var likedImpressions = [Impressions]()
    @Published var isLoading = false
    
    init(user:User){
        self.user = user
        fetchUserImpressions()
        fetchUserLikedImpressions()
    }
    
    var isCurrentUser:Bool {
        
        if user.id == AuthViewModel.shared.currentUser?.id {
            return true
        }else{
            return false
        }
    }
    
    //自分の投稿をロードする
    func fetchUserImpressions(){
        
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        isLoading = true
        COLLECTION_POSTS.whereField("postUserID",isEqualTo: uid).getDocuments { snapshot, error in
            
            if error != nil{
                
                self.isLoading = false
                return
            }
            
            guard let documents = snapshot?.documents else {
                
                self.isLoading = false
                return
            }
            
            self.userImpressions = documents.compactMap({try? $0.data(as: Impressions.self)})
            self.isLoading = false
        }
    }
    
    //お気に入りした投稿をロードする
    func fetchUserLikedImpressions(){
        
        var impressions = [Impressions]()
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        isLoading = true
        
        COLLECTION_USER.document(uid).collection("user-likes").getDocuments { snapshot,error in
            
            if error != nil{
                
                self.isLoading = false
                return
            }
            
            guard let documents = snapshot?.documents else {
                self.isLoading = false
                return
            }
            
            guard documents.count != 0 else {
                
                self.isLoading = false
                return
            }
            
            documents.forEach { doc in
                
                let id = doc.documentID
                COLLECTION_POSTS.document(id).getDocument { snapshot, _ in
                    
                    guard let impression = try? snapshot?.data(as: Impressions.self) else {
                        
                        self.isLoading = false
                        return
                    }
                    
                    impressions.append(impression)
                    
                    self.likedImpressions = impressions
                    self.isLoading = false
                }
            }
        }
    }
    
    //選択したボタン(selectedfilter)に応じて返却するImpressionを変える
    func impressions(forFilter filter:ProfileFilterOptions) -> [Impressions] {
        switch filter {
        case .impressions:return userImpressions
        case .likes:return likedImpressions
        }
    }
}
