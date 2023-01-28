//
//  SearchBookView.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/24.
//

import SwiftUI

struct SearchBooksView: View {
    
    @State private var searchText = ""
    @State private var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    @ObservedObject var searchBooksViewModel = SearchBooksViewModel()
    @FocusState private var isEditing:Bool

    var body: some View {
        
            VStack{
                SearchBar(text: $searchText)
                    .focused($isEditing)
                    .onSubmit {
                        guard let searchURL = searchBooksViewModel.researchBooks(searchText) else {return}
                        searchBooksViewModel.downloadData(url: searchURL)
                    }
                    
                    ScrollView(.vertical,showsIndicators: true) {
                        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                            ForEach(searchBooksViewModel.books) { book in
                                
                            BookCellMock2(book: book)
                                
                        }
                    }
                }.padding(.top,10)
            }
            .padding(.top,10)
            .onAppear{
                searchBooksViewModel.downloadData(url: "https://www.googleapis.com/books/v1/volumes?q=business")
            }
    }
}

struct SearchBooksView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBooksView()
    }
}
