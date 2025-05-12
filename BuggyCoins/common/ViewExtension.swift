//
//  ViewExtension.swift
//  BuggyCoins
//
//  Created by Sakda Suwantheerangkoon on 24/5/2568 BE.
//

import SwiftUI

extension View {

    @inlinable nonisolated public func fillScreenWithBlurryStatusBar(
        isfadedBottom: Bool = false
    ) -> some View {
        let bgColor = Color("AppBG")
        return self
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .overlay(alignment: .top) {
                Color.clear
                    .ignoresSafeArea(edges: .top)
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .background(.ultraThinMaterial)
            }
            .overlay(alignment: .bottom) {
                if isfadedBottom {
                    LinearGradient(
                        colors: [bgColor.opacity(0.9), bgColor.opacity(0.5), bgColor.opacity(0)],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .ignoresSafeArea(edges: .bottom)
                    .frame(maxWidth: .infinity, maxHeight: 32)
                }
            }
    }
    
    @inlinable nonisolated public func navDestination(
        isPresented: Binding<Bool>,
        @ViewBuilder content: () -> some View
    ) -> some View {
        return self
            .overlay {
                NavigationLink(
                    destination: content()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true),
                    isActive: isPresented,
                    label: { EmptyView() }
                )
            }
    }
}
