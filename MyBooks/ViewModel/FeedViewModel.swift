//
//  FeedViewModel.swift
//  MyBooks
//
//  Created by Junpei  on 2022/12/01.
//

import SwiftUI
import FirebaseFirestore

class FeedViewModel:ObservableObject{
    
    @Published var impressions = [Impressions]()
    
    init(){
        loadImpressions()
    }
    
    //投稿、保存したデータを全てダウンロードする
    func loadImpressions() {
        COLLECTION_POSTS.order(by: "postDate").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            self.impressions = documents.compactMap({try? $0.data(as: Impressions.self)})
            //print("impressions:",self.impressions)
        }
    }
    
    //書籍のタイトルなどで検索をする
    func filteredImpressions(_ query:String) -> [Impressions] {
        let lowercaseQuery = query.lowercased()
        let filtered = impressions.filter({$0.bookTitle.lowercased().contains(lowercaseQuery) })
        print(filtered)
        return filtered
    }
}


