//
//  FeedCellViewModel.swift
//  MyBooks
//
//  Created by Junpei  on 2022/12/01.
//

import Foundation

class FeedCellViewModel: ObservableObject {
    @Published var impressions:Impressions
    
    init(impressions:Impressions){
        self.impressions = impressions
        self.checkIfUserLike()
    }
    
    func like() {
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = impressions.id else {return}
        COLLECTION_POSTS.document(postId).collection("post-likes").document(uid).setData([:]){_ in
            COLLECTION_USER.document(uid).collection("user-likes").document(postId).setData([:]){_ in
                self.impressions.didLike = true
                
            }
        }
    }
    
    func unlike(){
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = impressions.id else {return}
        COLLECTION_POSTS.document(postId).collection("post-likes").document(uid).delete {_ in
            COLLECTION_USER.document(uid).collection("user-likes").document(postId).delete{_ in
                self.impressions.didLike = false
                
            }
        }
    }
    
    //自分がいいねした投稿一覧(user-likes:投稿ID)を取ってくる→いいねの表示に反映する
    func checkIfUserLike() {
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = impressions.id else {return}
        COLLECTION_USER.document(uid).collection("user-likes").document(postId).getDocument { snapshot, _ in
            guard let didLike = snapshot?.exists else {return}
            self.impressions.didLike = didLike
        }
    }
}
