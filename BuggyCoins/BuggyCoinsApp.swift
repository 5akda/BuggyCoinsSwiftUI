//
//  BuggyCoinsApp.swift
//  BuggyCoins
//
//  Created by Sakda Suwantheerangkoon on 10/5/2568 BE.
//

import SwiftUI

@main
struct BuggyCoinsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView().navigationBarHidden(true)
            }
        }
    }
}
