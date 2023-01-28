//
//  BookCellMock.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/24.
//

import SwiftUI

struct BookCellMock: View {
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "text.book.closed")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70,height: 70)
                    .foregroundColor(.black)
                    
                VStack(alignment: .leading,spacing: 8){
                    Text("未タイトル")
                        .font(.system(size: 20,weight: .bold))
                    Text("著者不明")
                        .font(.system(size: 12, weight: .light))
                }
                Text("説明")
                    .font(.caption2)
                    .padding(.leading, 20)
                Spacer()
            }
            .padding([.leading,.top],10)
            Divider()
        }
        .padding(.horizontal,8)
    }
}

struct BookCellMock_Previews: PreviewProvider {
    static var previews: some View {
        BookCellMock()
            .previewLayout(.sizeThatFits)
    }
}
