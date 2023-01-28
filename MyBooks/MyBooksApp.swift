//
//  MyBooksApp.swift
//  MyBooks
//
//  Created by Junpei  on 2022/11/09.
//

import SwiftUI
import Firebase

@main
struct MyBooksApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }
}
