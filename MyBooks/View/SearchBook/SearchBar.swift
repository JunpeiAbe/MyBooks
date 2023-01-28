//
//  SearchBar.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/24.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    
    var body: some View {
        HStack{
            TextField("\(Image(systemName: "magnifyingglass"))書籍の検索",text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .foregroundColor(.black)
                .cornerRadius(10)
                .textInputAutocapitalization(.never)
            Button(action: {
                    text = ""
                }) {
                    Image(systemName:"delete.right")
                        .foregroundColor(.black)
                        .padding(.trailing, 5)
                }
        }
        .padding(.horizontal, 10)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
