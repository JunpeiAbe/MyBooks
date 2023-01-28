//
//  User.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/25.
//

import SwiftUI
import FirebaseFirestoreSwift

struct User:Decodable,Identifiable{
    @DocumentID var id: String?
    let userName:String
    let fullName:String
    let email:String
    let profileImageURL: String
    var bio:String?
    
    var userImageURL: URL? {
        return URL(string: profileImageURL)
    }
}


