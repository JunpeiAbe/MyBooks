//
//  ProfileButtonView.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/25.
//

import SwiftUI

enum ProfileFilterOptions:Int,CaseIterable {
    case impressions
    case likes
    
    var title: String {
        switch self {
        case .impressions: return "投稿履歴"
        case .likes: return "お気に入り"
        }
    }
}

struct ProfileButtonView: View {
    
    @ObservedObject var profileViewModel:ProfileViewModel
    @Binding var selectedOption: ProfileFilterOptions
    @Binding var showEditProfile:Bool
    
    var body: some View {
        VStack {
            if profileViewModel.isCurrentUser {
                Button(action: {
                    showEditProfile.toggle()
                }) {
                    Text("プロフィールを編集")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 32)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }.sheet(isPresented: $showEditProfile) {
                    EditProfileView(user: $profileViewModel.user)
                }
            }
            HStack{
                Button(action: {
                    selectedOption = .impressions
                    profileViewModel.fetchUserImpressions()
                }) {
                    Text("投稿履歴\(Image(systemName: "paperplane"))")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: UIScreen.main.bounds.width * 0.45, height: 32)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                Button(action: {
                    selectedOption = .likes
                    profileViewModel.fetchUserLikedImpressions()
                }) {
                    Text("おきにいり\(Image(systemName: "heart"))")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: UIScreen.main.bounds.width * 0.45, height: 32)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
            }
        }
        
    }
}


