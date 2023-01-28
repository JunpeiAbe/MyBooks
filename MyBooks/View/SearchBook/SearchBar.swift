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
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                )
                .foregroundColor(.black)
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

