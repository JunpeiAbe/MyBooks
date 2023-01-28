//
//  MainTabView.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/24.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedIndex = 0
    @EnvironmentObject var authViewModel:AuthViewModel
    
    init() {
            UITabBar.appearance().backgroundColor = .white
            UINavigationBar.appearance().backgroundColor = .white
        }
    
    var tabTitle: String {
        switch selectedIndex {
        case 0: return "本の検索"
        case 1: return "みんなの投稿"
        case 2: return "プロフィール"
        default: return ""
        }
    }
    
    var body: some View {
        
        if let user = authViewModel.currentUser {
            NavigationView {
                TabView(selection: $selectedIndex){
                    SearchBooksView()
                        .onTapGesture {
                            selectedIndex = 0
                        }
                        .tabItem{
                            Image(systemName: "magnifyingglass.circle.fill")
                            Text("本の検索")
                        }
                        .tag(0)
                    FeedView()
                        .onTapGesture {
                            selectedIndex = 1
                        }
                        .tabItem{
                            Image(systemName: "list.bullet.circle.fill")
                            Text("みんなの投稿")
                        }
                        .tag(1)
                    ProfileView(user: user)
                        .onTapGesture {
                            selectedIndex = 2
                        }
                        .tabItem{
                            Image(systemName: "person.circle.fill")
                            Text("プロフィール")
                        }
                        .tag(2)
                }
                .accentColor(.brown)
                .navigationTitle(tabTitle)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
