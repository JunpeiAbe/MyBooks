//
//  BookCell.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/11.
//

import SwiftUI
//import Kingfisher

struct BookCell: View {
    
    let book:Book
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(systemName: "text.book.closed")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50,height: 50)
                    .foregroundColor(Color(.systemGray))
                
                VStack(alignment: .leading,spacing: 8){
                    Text(book.volumeInfo.title ?? "未タイトル")
                        .font(.system(size: 20,weight: .bold))
                        .lineLimit(1)
                    Text(book.volumeInfo.authors?[0] ?? "著者不明")
                        .font(.system(size: 12, weight: .light))
                        .lineLimit(1)
                }
                .padding(5)
                Text(book.volumeInfo.description ?? "")
                    .font(.system(size: 10, weight: .ultraLight))
                    .frame(width: 200,alignment: .topLeading)
                
                
            }
            .padding(.leading)
            Divider()
        }
        
        
    }
}

struct BookCell_Previews: PreviewProvider {
    
    static var book = Book(id: "", volumeInfo: VolumeInfo(title: "鬼滅の刃", authors: ["吾峠呼世晴"], publisher: "集英社", publishedDate: "2021.10.10", description: "大正時代、人を喰らう鬼が街に蔓延っていた。炭焼きの少年、竈門炭治郎と妹のねずこは家族を鬼に殺された過去を持つ。鬼に復讐するための兄弟の旅が始まる。", imageLinks: ImageLinks(smallThumbnail: "", thumbnail: "")))
    
    static var previews: some View {
        BookCell(book: book)
            .previewLayout(.sizeThatFits)
    }
}
