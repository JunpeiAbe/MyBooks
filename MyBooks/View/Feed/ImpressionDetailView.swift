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
                    KFImage(URL(string: feedCellViewModel.impressions.postUserImageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50,height: 50)
                        .clipShape(Circle())
                    Text(feedCellViewModel.impressions.postUserName)
                        .bold()
                    Spacer()
                    Button(action: {
                        didLike ? feedCellViewModel.unlike():feedCellViewModel.like()
                        print(didLike)
                    }) {
                        
                        Image(systemName: didLike ? "heart.fill":"heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20,height: 20)
                            .foregroundColor(didLike ? .pink:.black)
                    }
                }
                HStack{
                    if let imageURL = feedCellViewModel.impressions.bookThumbnail {
                        KFImage(URL(string: imageURL))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100,height: 100)
                    }else{
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100,height: 100)
                            .foregroundColor(Color(.systemGray6))
                    }
                    VStack(alignment: .leading,spacing: 5){
                        Text(feedCellViewModel.impressions.bookTitle)
                            .font(.title)
                            .bold()
                            .baselineOffset(5)
                            .underline(true,color: .purple)
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
        
    }
}

struct ImpressionDetailView_Previews: PreviewProvider {
    
    static var  impressions = mockImp
    
    static var previews: some View {
        ImpressionDetailView(feedCellViewModel: FeedCellViewModel(impressions: impressions))
            .previewLayout(.sizeThatFits)
    }
}
