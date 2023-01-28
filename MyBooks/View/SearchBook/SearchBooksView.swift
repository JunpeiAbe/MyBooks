//
//  SearchBookView.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/24.
//

import SwiftUI

struct SearchBooksView: View {
    
    @State private var showAlert = false
    @State private var searchText = ""
    @State private var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    @StateObject var searchBooksViewModel = SearchBooksViewModel()
    @FocusState private var isEditing:Bool

    var body: some View {
        
        ZStack{
            if searchBooksViewModel.isLoading{
                LoadingIndicator().zIndex(1.0)
            }
            VStack{
                SearchBar(text: $searchText)
                    .focused($isEditing)
                    .onSubmit {
                        if !searchText.isEmpty{
                            searchBooksViewModel.searchKeyWord = searchText.lowercased()
                            Task{
                                try await searchBooksViewModel.fetchBooksData()
                            }
                        }else{
                            
                        }
                    }
                
                ScrollView(.vertical,showsIndicators: true) {
                    LazyVGrid(columns: gridLayout, alignment: .center, spacing: 5) {
                        ForEach(searchBooksViewModel.books) { book in
                            BookCell(book: book)
                        }
                    }
                }.padding(.top,10)
            }
            .padding(.top,10)
            .onReceive(searchBooksViewModel.$errorMessage, perform: {errorMessage in
                if errorMessage != nil {
                    self.showAlert.toggle()
                }
            })
            .alert(Text(searchBooksViewModel.errorMessage ?? "エラー"), isPresented: $showAlert) {
                Button("OK"){
                    searchBooksViewModel.errorMessage = nil
                }
            }
        }
    }
}

