//
//  EditProfileViewModel.swift
//  MyBooks
//
//  Created by Junpei  on 2022/12/04.
//

import Foundation

class EditProfileViewModel:ObservableObject {
    var user:User
    
    init(user:User){
        self.user = user
    }
    
    func saveUserBio(bioText:String,completion:(@escaping () -> Void)) {
        guard let uid = user.id else {return}
        COLLECTION_USER.document(uid).updateData(["bio":bioText]){ _ in
            self.user.bio = bioText
            completion()
        }
    }
}
