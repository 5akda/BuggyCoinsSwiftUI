//
//  NavigableScreen.swift
//  BuggyCoins
//
//  Created by Sakda Suwantheerangkoon on 11/5/2568 BE.
//

import SwiftUI

struct NavigableScreen<Content: View> : View {
    var trigger: Binding<Bool>
    @ViewBuilder let content: Content
    
    var body: some View {
        NavigationLink(
            destination: getContentWithoutNavBar(),
            isActive: trigger,
            label: { EmptyView() }
        )
    }
    
    private func getContentWithoutNavBar() -> some View {
        return content
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
}
