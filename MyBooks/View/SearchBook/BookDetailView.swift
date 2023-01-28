//
//  BookDetailView.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/24.
//

import SwiftUI
import Kingfisher

struct BookDetailView: View {
    
    @State private var showPostImpressionView = false
    let book:Book
    
    var body: some View {
            ScrollView {
                VStack{
                    HStack{
                        if let imageURL = book.volumeInfo.imageLinks?.thumbnail {
                            KFImage(URL(string: imageURL))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130,height: 130)
                        }else{
                            Image(systemName: "text.book.closed")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130,height: 130)
                                .foregroundColor(Color(.systemGray6))
                        }
                        
                        VStack(alignment: .leading,spacing: 10){
                            Text(book.volumeInfo.title ?? "タイトル不明").font(.title).bold()
                            Text(book.volumeInfo.authors?[0] ?? "著者不明").font(.title2)
                            Text(book.volumeInfo.publisher ?? "出版社不明").font(.title2)
                            Text(book.volumeInfo.publishedDate ?? "").font(.caption).foregroundColor(.gray)
                        }
                    }
                    Divider()
                    
                    Text(book.volumeInfo.description ?? "---")
                        .frame(width:UIScreen.main.bounds.width * 0.9,alignment: .topLeading)
                    .font(.caption)
                    .padding(.top,10)
                    Button(action: {
                        showPostImpressionView.toggle()
                    }) {
                        Text("感想の投稿")
                    }
                    .foregroundColor(.white)
                    .padding(20)
                    .background{Capsule().foregroundColor(.teal)}
                    .shadow(color:.gray,radius: 5)
                    .padding(.top,10)
                    .sheet(isPresented: $showPostImpressionView, content: {PostImpressionsView(book: book)})
                }
            }
            .navigationTitle("書籍の詳細")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct BookDetailView_Previews: PreviewProvider {
    
    static var book = mockData
    static var previews: some View {
        BookDetailView(book: book)
    }
}
