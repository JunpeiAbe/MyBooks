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
    @Binding var showLogoutAlert:Bool
    @ObservedObject var profileViewModel:ProfileViewModel
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                AsyncImage(url: profileViewModel.user.userImageURL){ image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                }placeholder: {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80,height: 80)
                        .foregroundColor(Color(.systemGray4))
                        
                }
                Text(profileViewModel.user.userName)
                    .font(.title2)
                    .bold()
                    .padding(.horizontal,20)
                
                Spacer()
                
                Button("ログアウト"){
                    showLogoutAlert.toggle()
                }
                .font(.system(size: 14, weight: .semibold))
                .padding(10)
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
            }.padding(.horizontal,10)
            
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


