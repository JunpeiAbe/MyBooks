//
//  BooksViewModel.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/09.
//

import Foundation

class SearchBooksViewModel:ObservableObject{
    
    @Published var books = [Book]()
    
    init() {
        //downloadData()
    }
    
    let baseURL = "https://www.googleapis.com/books/v1/volumes?q=business"
    //var searchURL = "https://www.googleapis.com/books/v1/volumes?q=\(searchKeyword)"
    
    func downloadData(url:String?){
        print("booksData download")
        guard let url = URL(string: url ?? "") else { print("urlなし"); return}
        let urlSession = URLSession.shared
        
        urlSession.dataTask(with: url) { data, urlResponce, error in
            if error != nil {
                print(error!)
            }
            
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                print("DispatchQueue.main.async")
                do{
                    print("do")
                    let json = try JSONDecoder().decode(Items.self, from: data)
                    self.books = json.items
                }catch{
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func researchBooks(_ keyword:String) -> String? {
        let lowercaseKeyword = keyword.lowercased() //小文字への変換
        let url = "https://www.googleapis.com/books/v1/volumes?q=\(lowercaseKeyword)"
        print("url",url)
        return url
    }
    
    
}
