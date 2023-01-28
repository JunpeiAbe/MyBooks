//
//  ImpressionDetailView.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/24.
//

import SwiftUI
import Kingfisher

struct ImpressionDetailView: View {
    
    var didLike:Bool{return feedCellViewModel.impressions.didLike ?? false}
    @ObservedObject var feedCellViewModel:FeedCellViewModel
    
    var body: some View {
        ScrollView(.vertical){
            VStack(alignment: .leading,spacing: 20){
                HStack{Spacer()}
                HStack{
                    AsyncImage(url: feedCellViewModel.impressions.userImageURL){ image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50,height: 50)
                            .clipShape(Circle())
                    }placeholder: {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50,height: 50)
                            .foregroundColor(Color(.systemGray4))
                    }
                    Text(feedCellViewModel.impressions.postUserName)
                        .bold()
                    Spacer()
                    Button(action: {
                        didLike ? feedCellViewModel.unlike():feedCellViewModel.like()
                        
                    }) {
                        
                        Image(systemName: didLike ? "heart.fill":"heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20,height: 20)
                            .foregroundColor(didLike ? .pink:.black)
                    }
                }
                HStack(spacing: 20){
                    AsyncImage(url: feedCellViewModel.impressions.bookImageURL){ image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100,height: 100)
                    }placeholder: {
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100,height: 100)
                            .foregroundColor(Color(.systemGray4))
                    }
                    VStack(alignment: .leading,spacing: 5){
                        Text(feedCellViewModel.impressions.bookTitle)
                            .font(.title)
                            .bold()
                            .lineLimit(3)
                        Text("投稿日\(feedCellViewModel.impressions.timestampString)")
                    }
                }
                Divider()
                Text(feedCellViewModel.impressions.impressionsText)
                    .frame(width:UIScreen.main.bounds.width * 0.9,alignment:.topLeading)
            }
            .padding(.horizontal,20)
        }
        .onAppear {
            feedCellViewModel.checkIfUserLike()
        }
        
    }
}

struct ImpressionDetailView_Previews: PreviewProvider {
    
    static var  impressions = mockImp
    
    static var previews: some View {
        ImpressionDetailView(feedCellViewModel: FeedCellViewModel(impressions: impressions))
            .previewLayout(.sizeThatFits)
    }
}
