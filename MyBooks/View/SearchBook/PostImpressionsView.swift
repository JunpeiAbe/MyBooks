//
//  PostImpressionView.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/24.
//

import SwiftUI
import FirebaseFirestore

struct PostImpressionsView: View {
    
    @State private var impressionsText = ""
    @Environment (\.dismiss) var dismiss
    let book:Book
    var buttonIsDisabled:Bool {
        return impressionsText.isEmpty
    }

    var body: some View {
        VStack{
            HStack{
                AsyncImage(url: book.volumeInfo.imageLinks?.imageUrl){ image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70,height: 70)
                    
                } placeholder: {
                    Image(systemName: "text.book.closed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70,height: 70)
                        .foregroundColor(Color(.systemGray4))
                }
                Text(book.volumeInfo.title ?? "タイトル不明").font(.title).bold()
                Spacer()
            }.padding(.leading,10)
            
            TextField("書籍の感想",text: $impressionsText,axis: .vertical)
                .frame(width:UIScreen.main.bounds.width * 0.9,height: 200,alignment: .topLeading)
                .border(Color(.systemGray4))
            
            
            Button(action: {
                postImpressions(book: book, impressionsText: impressionsText, completion:{
                    dismiss()
                })
            }) {
                Text("感想を投稿する")
            }
            .disabled(buttonIsDisabled)
            .foregroundColor(.white)
            .padding(20)
            .frame(width: UIScreen.main.bounds.width - 30)
            .background{
                Capsule()
                    .foregroundColor(buttonIsDisabled ? .gray : .mint)
            }
            .shadow(color:.gray,radius: 5)
            .padding(.top,10)
            
            Spacer()
        }
        .padding(.top,20)
        .navigationTitle("感想の投稿")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func postImpressions(book:Book,impressionsText:String, completion:@escaping (()->Void)) {
        
        guard let postUserID = AuthViewModel.shared.userSession?.uid else {return}
        guard let postUserName = AuthViewModel.shared.currentUser?.userName else {return}
        guard let postUserImageURL = AuthViewModel.shared.currentUser?.profileImageURL else {return}
        
        let data = ["bookTitle":book.volumeInfo.title as Any,
                    "bookThumbnail":book.volumeInfo.imageLinks?.thumbnail as Any,
                    "bookAuthors":book.volumeInfo.authors as Any,
                    "impressionsText":impressionsText,
                    
                    "postUserID":postUserID,
                    "postUserName":postUserName,
                    "postUserImageURL":postUserImageURL,
                    
                    "postDate":Timestamp(),
                    "likes":0
        ] as [String : Any]
        
        COLLECTION_POSTS.addDocument(data: data){_ in
            completion()
        }
    }
    
}


