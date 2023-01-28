//
//  ProfileView.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/24.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var selectedFilter:ProfileFilterOptions = .impressions
    @State private var showAlert = false
    @State private var showEditProfile = false
    @State private var showLogoutAlert = false
    @ObservedObject var profileViewModel:ProfileViewModel
    @EnvironmentObject var authViewModel:AuthViewModel
    private let user:User
    
    init(user:User){
        self.user = user
        profileViewModel = ProfileViewModel(user:user)
    }
    
    var body: some View {
        ZStack{
            if profileViewModel.isLoading{
                LoadingIndicator().zIndex(1.0)
            }
            VStack{
                ProfileHeaderView(selectedOption: $selectedFilter, showEditProfile: $showEditProfile, showLogoutAlert: $showLogoutAlert, profileViewModel: profileViewModel)
                
                Divider()
        
                ScrollView(.vertical){
                    ForEach(profileViewModel.impressions(forFilter: selectedFilter)){ impressions in
                        switch selectedFilter {
                        case .impressions:
                            if profileViewModel.userImpressions.isEmpty{
                                VStack(alignment: .center){
                                    Spacer()
                                    Text("投稿履歴がありません").foregroundColor(.gray)
                                    Spacer()
                                }
                            }else{
                                NavigationLink {
                                    ImpressionDetailView(feedCellViewModel: FeedCellViewModel(impressions: impressions))
                                } label: {
                                    PostRecordCell(impressions: impressions)
                                }.foregroundColor(.black)
                            }
                        case .likes:
                            if profileViewModel.likedImpressions.isEmpty{
                                Text("おきにいり投稿がありません").foregroundColor(.gray)
                            }else{
                                NavigationLink {
                                    ImpressionDetailView(feedCellViewModel: FeedCellViewModel(impressions: impressions))
                                } label: {
                                    ImpressionCell(feedCellViewModel:
                                    FeedCellViewModel(impressions: impressions))
                                }.foregroundColor(.black)
                            }
                        }
                    }
                }
            }
            .onReceive(authViewModel.$errorMessage, perform: {errorMessage in
                if errorMessage != nil {
                    self.showAlert.toggle()
                }
            })
            .alert(Text(authViewModel.errorMessage ?? ""), isPresented: $showAlert) {
                Button("OK"){
                    authViewModel.errorMessage = nil
                }
            }
            .alert("ログアウトしますか?", isPresented: $showLogoutAlert) {
                Button("キャンセル",role: .cancel) {}
                Button("OK") {
                    authViewModel.signout()
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
