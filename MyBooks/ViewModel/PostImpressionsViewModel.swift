//
//  PostImpressionsViewModel.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/30.
//

import FirebaseFirestore

class PostImpressionsViewModel:ObservableObject{
    
    //@Published var impressions:Impressions
    
//    init(impressions: Impressions) {
//        self.impressions = impressions
//    }
    //firebaseにimpressionsを保存する(Impressions型)
    
    func postImpressions(book:Book,impressionsText:String, completion: ((Error?) -> Void)?) {
        
        guard let postUserID = AuthViewModel.shared.userSession?.uid else {return}
        guard let postUserName = AuthViewModel.shared.currentUser?.userName else {return}
        guard let postUserImageURL = AuthViewModel.shared.currentUser?.profileImageURL else {return}
        
        let data = ["bookTitle":book.volumeInfo.title as Any,
                    "bookThumbnail":book.volumeInfo.imageLinks?.thumbnail as Any,
                    "bookAuthors":book.volumeInfo.authors as Any,
                    "impressionsText":impressionsText,
                    
                    "postUserID":postUserID,
                    "postUserName":postUserName,
                    "postUserImageURL":postUserImageURL,
                    
                    "postDate":Timestamp(),
                    "likes":0
        ] as [String : Any]
        
        COLLECTION_POSTS.addDocument(data: data,completion:completion)
    }
    
}
