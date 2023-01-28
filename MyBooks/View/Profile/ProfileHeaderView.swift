//
//  ProfileHeaderView.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/25.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    
    @Binding var selectedOption: ProfileFilterOptions
    @Binding var showEditProfile:Bool
    @ObservedObject var profileViewModel:ProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                KFImage(URL(string: profileViewModel.user.profileImageURL))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(.leading)
                Text(profileViewModel.user.userName)
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.horizontal,20)
                Spacer()
            }
            
            if let bio = profileViewModel.user.bio {
                Text(bio)
                    .font(.system(size: 15))
                    .padding(.leading)
                    .padding(.top, 5)
                    .lineLimit(4)
            }
            
            HStack{
                Spacer()
                ProfileButtonView(profileViewModel: profileViewModel, selectedOption: $selectedOption, showEditProfile: $showEditProfile)
                Spacer()
            }
        }
    }
}

//struct ProfileHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileHeaderView()
//            .previewLayout(.sizeThatFits)
//    }
//}
