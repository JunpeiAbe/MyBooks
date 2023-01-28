//
//  ProfileView.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/24.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var selectedFilter:ProfileFilterOptions = .impressions
    private let user:User
    @ObservedObject var profileViewModel:ProfileViewModel
    @State private var showEditProfile = false
    
    init(user:User){
        self.user = user
        profileViewModel = ProfileViewModel(user:user)
    }
    
    var body: some View {
        VStack{
            
            ProfileHeaderView(selectedOption: $selectedFilter, showEditProfile: $showEditProfile, profileViewModel: profileViewModel)
            
            Divider()
            
            ScrollView(.vertical){
                ForEach(profileViewModel.impressions(forFilter: selectedFilter)){ impressions in
                    if selectedFilter == .impressions{
                        PostRecordCell(impressions: impressions)
                    }else{
                        ImpressionCell(feedCellViewModel: FeedCellViewModel(impressions: impressions))
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(userName: "あべ", fullName: "あべじゅんぺい", email: "◯○○@gmail.com", profileImageURL: ""))
    }
}
