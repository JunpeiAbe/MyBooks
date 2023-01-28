//
//  CustomTextField.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/25.
//

import SwiftUI

struct CustomTextField: View {
    
    let imageName: String
    let placeholderText: String
    let isSecureField: Bool
    @Binding var text: String
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25,height: 25)
                
                if isSecureField {
                    SecureField(placeholderText, text: $text)
                }else{
                    TextField(placeholderText, text: $text)
                }
            }
            .foregroundColor(.black)
            .padding(.horizontal)
            Divider()
                .background(Color(.darkGray))
        }
        .padding(.horizontal)
    }
}

