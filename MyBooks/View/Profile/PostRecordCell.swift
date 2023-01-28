//
//  PostRecordCell.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/25.
//

import SwiftUI
import Kingfisher

struct PostRecordCell: View {
    
    let impressions:Impressions
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                if let bookThumnail = impressions.bookThumbnail {
                    KFImage(URL(string: bookThumnail))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80,height: 80)
                }else{
                    Image(systemName: "text.book.closed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80,height: 80)
                }
                
                VStack(alignment: .leading){
                    HStack {
                        Text(impressions.bookTitle)
                            .bold()
                            .baselineOffset(5)
                            .frame(maxWidth:230,alignment: .leading)
                            .underline(true,color: .black)
                            .lineLimit(1)
                        Spacer()
                        Text(impressions.timestampString)
                            .foregroundColor(Color(.systemGray))
                    }
                    Text(impressions.impressionsText)
                        .frame(height: 60,alignment: .topLeading)
                        .font(.system(size: 14))
                        .lineLimit(3)
                }.frame(width: UIScreen.main.bounds.width * 0.70)
            }
            Divider()
        }
        .frame(width: UIScreen.main.bounds.width * 0.95)
}
    }


struct PostRecordCell_Previews: PreviewProvider {
    static var  impressions = mockImp
    static var previews: some View {
        PostRecordCell(impressions: impressions).previewLayout(.sizeThatFits)
    }
}
