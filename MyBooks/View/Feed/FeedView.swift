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
        
        ZStack{
            if feedViewModel.isLoading{
                LoadingIndicator().zIndex(1.0)
            }
            VStack{
                SearchBar(text: $searchText)
                    .focused($isEditing)
                
                ScrollView(.vertical,showsIndicators: true) {
                    ForEach(searchText.isEmpty ? feedViewModel.impressions:feedViewModel.filteredImpressions(searchText)) { impressions in
                        NavigationLink(
                            destination: {
                                ImpressionDetailView(feedCellViewModel: FeedCellViewModel(impressions: impressions))
                            },
                            label: {
                                ImpressionCell(feedCellViewModel: FeedCellViewModel(impressions: impressions))
                            }).foregroundColor(.black)
                    }.padding(.top,20)
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
