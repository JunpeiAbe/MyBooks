//
//  BookCell.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/11.
//

import SwiftUI
import SwiftUI

struct BookCell: View {
    
    let book:Book
    
    var body: some View {
        NavigationLink(destination: {BookDetailView(book:book)}) {
            VStack{
                AsyncImage(url: book.volumeInfo.imageLinks?.imageUrl){ image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.25)
                } placeholder: {
                    Image(systemName: "text.book.closed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.25)
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.3)
        }.foregroundColor(Color(.systemGray4))
    }
}


struct BookCell_Previews: PreviewProvider {
    
    static var book = Book(id: "", volumeInfo: VolumeInfo(title: "鬼滅の刃", authors: ["吾峠呼世晴"], publisher: "集英社", publishedDate: "2021.10.10", description: "大正時代、人を喰らう鬼が街に蔓延っていた。炭焼きの少年、竈門炭治郎と妹のねずこは家族を鬼に殺された過去を持つ。鬼に復讐するための兄弟の旅が始まる。", imageLinks: ImageLinks(smallThumbnail: "", thumbnail: "")))
    
    static var previews: some View {
        BookCell(book: book)
            .previewLayout(.sizeThatFits)
    }
}
