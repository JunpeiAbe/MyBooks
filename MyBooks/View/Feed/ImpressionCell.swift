//
//  ImpressionCell.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/24.
//

import SwiftUI
//import Kingfisher

struct ImpressionCell: View {
    
    var didLike:Bool{return feedCellViewModel.impressions.didLike ?? false}
    @ObservedObject var feedCellViewModel:FeedCellViewModel
    
    var body: some View {
            VStack(alignment: .leading){
                HStack{
                    VStack(spacing: 5){
                        Text(feedCellViewModel.impressions.postUserName)
                            .lineLimit(1)
                            .font(.system(size: 12))
                            .frame(width: 50,alignment: .leading)
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
                    }
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text(feedCellViewModel.impressions.bookTitle)
                                .bold()
                                .frame(maxWidth: 200,alignment: .leading)
                                .lineLimit(1)
                            Spacer()
                            Text(feedCellViewModel.impressions.timestampString)
                                .foregroundColor(Color(.systemGray))
                        }
                        
                        Text(feedCellViewModel.impressions.impressionsText)
                            .frame(height: 60,alignment: .topLeading)
                            .lineLimit(3)
                            .font(.system(size: 14))
                    }.frame(width: UIScreen.main.bounds.width * 0.65)
                    
                    Button(action: {
                         didLike ? feedCellViewModel.unlike() : feedCellViewModel.like()
                    }) {
                        Image(systemName: didLike ? "heart.fill":"heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20,height: 20)
                            .foregroundColor(didLike ? .pink :.black)
                            .padding(.leading,10)
                        
                    }
                }
                Divider()
            }
            .frame(width: UIScreen.main.bounds.width * 0.95)
            .onAppear {
                feedCellViewModel.checkIfUserLike()
            }
    }
}

struct ImpressionCell_Previews: PreviewProvider {
    
    static var  impressions = mockImp
    
    static var previews: some View {
        ImpressionCell(feedCellViewModel: FeedCellViewModel(impressions:impressions ))
            .previewLayout(.sizeThatFits)
    }
}
