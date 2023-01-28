//
//  Impressions.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/30.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Impressions:Decodable,Identifiable {
    
    @DocumentID var id:String?
    let bookTitle:String
    let bookThumbnail:String?
    let bookAuthors:[String]?
    let impressionsText:String //自分の感想
    let postUserID:String 
    let postUserName:String
    let postUserImageURL:String
    let postDate:Timestamp //投稿日
    let likes:Int //お気に入りされた数
    
    var didLike:Bool? = false
    
    var timestampString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.M.d"
        return formatter.string(from: postDate.dateValue())
    }
    
    var userImageURL: URL? {
        return URL(string: postUserImageURL)
    }
    
    var bookImageURL: URL? {
        return URL(string: bookThumbnail ?? "")
    }
    
}

var mockImp = Impressions(bookTitle: "鬼滅の刃", bookThumbnail: "", bookAuthors: ["吾峠呼世晴、大今良時、石田スイ"], impressionsText: "近年稀に見る超大作の気配。10年100年読み続けられる作品になると思います。", postUserID: "", postUserName: "高槻泉", postUserImageURL: "https://firebasestorage.googleapis.com:443/v0/b/mybook-934f4.appspot.com/o/profile_image%2F40312EEC-3CD8-4DFE-BA06-9FE45413F117?alt=media&token=77cfd272-cbf3-4947-8a72-d7da5dfe7142", postDate: Timestamp(date: Date(timeIntervalSince1970: 2022/12/04)), likes: 0)
