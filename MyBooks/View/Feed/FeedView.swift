//
//  FeedView.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/24.
//

import SwiftUI

struct FeedView: View {
    
    @State private var searchText = ""
    @State private var didLike = false
    @FocusState private var isEditing:Bool
    @ObservedObject var feedViewModel = FeedViewModel()
    
    var body: some View {
        VStack{
            SearchBar(text: $searchText)
                .focused($isEditing)
                
            ScrollView(.vertical,showsIndicators: true) {
                ForEach(searchText.isEmpty ? feedViewModel.impressions:feedViewModel.filteredImpressions(searchText)) { impressions in
                    NavigationLink(
                        destination: {ImpressionDetailView(feedCellViewModel: FeedCellViewModel(impressions: impressions))},
                        label: {
                            ImpressionCell(feedCellViewModel: FeedCellViewModel(impressions: impressions))
                        })
                }
            }
        }
        .padding(.top,10)
        .onAppear(perform: feedViewModel.loadImpressions)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
