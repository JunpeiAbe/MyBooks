//
//  BookCellMock2.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/25.
//

import SwiftUI
import Kingfisher

struct BookCellMock2: View {
    
    let book:Book
    
    var body: some View {
        
        NavigationLink(destination: {BookDetailView(book: book)}) {
            VStack{
                if let imageURL = book.volumeInfo.imageLinks?.thumbnail{
                    KFImage(URL(string: imageURL))
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.25)
                        
                }else{
                    Image(systemName: "text.book.closed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.25)
                        .foregroundColor(.black)
                }
                Text(book.volumeInfo.title ?? "未タイトル")
                    .underline(true,color: .black)
                    .lineLimit(2)
            }
            .frame(width: UIScreen.main.bounds.width * 0.3)
        }
    }
}

//struct BookCellMock2_Previews: PreviewProvider {
//
//    static var previews: some View {
//        BookCellMock2()
//    }
//}
