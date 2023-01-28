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
    @Published var isLoading = false
    
    init(){
        loadImpressions()
    }
    
    func loadImpressions() {
        isLoading = true
        COLLECTION_POSTS.order(by: "postDate",descending: true).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {
                self.isLoading = false
                return
            }
            self.impressions = documents.compactMap({try? $0.data(as: Impressions.self)})
            self.isLoading = false
            print("loadImpressions")
        }
    }
    
    func filteredImpressions(_ query:String) -> [Impressions] {
        let lowercaseQuery = query.lowercased()
        let filtered = impressions.filter({$0.bookTitle.lowercased().contains(lowercaseQuery) })
        return filtered
    }
}


