//
//  BooksViewModel.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/09.
//

import Foundation

class SearchBooksViewModel:ObservableObject{
    
    @Published var books = [Book]()
    @Published var searchKeyWord:String
    @Published var errorMessage:String?
    @Published var isLoading = false
    
    var baseURL: String {
        return "https://www.googleapis.com/books/v1/volumes?q=\(searchKeyWord)&maxResults=40".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    init() {
        searchKeyWord = "ビジネス"
        Task{
            try await fetchBooksData()
        }
    }
    
    @MainActor
    func fetchBooksData() async throws {
        do {
            isLoading = true
            guard let url = URL(string: baseURL) else {throw BooksError.invalidURL}
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw BooksError.serverError }
            guard let books = try? JSONDecoder().decode(Items.self, from: data) else { throw BooksError.invalidData }
            self.books = books.items
            
        }catch{
            isLoading = false
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
