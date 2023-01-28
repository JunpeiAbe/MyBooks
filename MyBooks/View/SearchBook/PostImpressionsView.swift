//
//  PostImpressionView.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/24.
//

import SwiftUI
import Kingfisher

struct PostImpressionsView: View {
    
    @State private var impressionsText = ""
    @Environment(\.dismiss) var dismiss
    let book:Book
    @ObservedObject var postImpressionsViewModel = PostImpressionsViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack{
                HStack{
                    if let imageURL = book.volumeInfo.imageLinks?.thumbnail{
                        KFImage(URL(string: imageURL))
                            .resizable()
                            .scaledToFit()
                            .frame(width:70,height: 70)
                        
                    }else{
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70,height: 70)
                            .foregroundColor(Color(.systemGray6))
                    }
                    Text(book.volumeInfo.title ?? "タイトル不明").font(.title).bold()
                    Spacer()
                }.padding(.leading,10)
                
                TextField("書籍の感想",text: $impressionsText,axis: .vertical)
                    .frame(width:UIScreen.main.bounds.width * 0.9,height: 200,alignment: .topLeading)
                    
                    .border(Color(.systemGray4))
                
                Button(action: {
                    if impressionsText.isEmpty {
                        
                    }else{
                        PostImpressionsViewModel().postImpressions(book: book, impressionsText: impressionsText) { _ in
                            dismiss()
                        }
                    }
                    
                }) {
                    Text("感想を投稿する")
                }
                .foregroundColor(.white)
                .padding(20)
                .background{Capsule().foregroundColor(.teal)}
                .shadow(color:.gray,radius: 5)
                .padding(.top,10)
                
                Spacer()
            }
            .padding(.top,20)
            .navigationTitle("感想の投稿")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct PostImpressionView_Previews: PreviewProvider {
    static var book = mockData
    static var previews: some View {
        PostImpressionsView(book:book)
    }
}
