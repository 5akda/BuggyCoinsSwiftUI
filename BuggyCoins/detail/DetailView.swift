//
//  DetailView.swift
//  BuggyCoins
//
//  Created by Sakda Suwantheerangkoon on 15/5/2568 BE.
//

import SwiftUI

struct DetailView: View {
    let coinSymbol: String?
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        getDetailView()
    }
    
    private func getDetailView() -> some View {
        return VStack {
            Text("Detail of \(coinSymbol ?? "nil jaa")")
            Button("BACK") {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .fillScreenWithBlurryStatusBar(isfadedBottom: false)
        .background(Color("AppBG"))
    }
}

#Preview {
    DetailView(coinSymbol: "btc")
}
