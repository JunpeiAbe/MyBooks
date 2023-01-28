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
    //Impression型のインスタンスをuserImpressionsとlikedImpressionsに分けて作る。
    @Published var userImpressions = [Impressions]()
    @Published var likedImpressions = [Impressions]()
    
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
        COLLECTION_POSTS.whereField("postUserID",isEqualTo: uid).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {return}
            self.userImpressions = documents.compactMap({try? $0.data(as: Impressions.self)})
            
        }
    }
    //お気に入りした投稿をロードする
    func fetchUserLikedImpressions(){
        
        var impressions = [Impressions]()
        
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        COLLECTION_USER.document(uid).collection("user-likes").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {return}
            //まとめて変換する(新しい配列を作る)例:["BNjPTB4UZNFC2nHEsJKl", "D4VgnQRn2V0azpARIXX6"]
            let documentIDs = documents.map{$0.documentID}
            
            print("documetIDs:",documentIDs)
            //個別のidを取り出してそれぞれパスにアクセスしデータを取得する
            documentIDs.forEach { id in
                COLLECTION_POSTS.document(id).getDocument { snapshot, error in
                    guard let impression = try? snapshot?.data(as: Impressions.self) else {return}
                    impressions.append(impression)
                    guard impressions.count == documentIDs.count else {return}
                    
                    self.likedImpressions = impressions
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
