//
//  extension+View.swift
//  QuotesApp
//
//  Created by Roman Rakhlin on 02.11.2021.
//

import SwiftUI

// MARK: - For Settings
extension View {
    func settingsBackground() -> some View {
        self
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground)))
            .padding(.bottom, 6)
            .padding(.horizontal)
    }

    func customHoverEffect() -> some View {
        if #available(macCatalyst 13.4, *), #available(iOS 13.4, *) {
            return AnyView(self.hoverEffect())
        } else {
            return AnyView(self)
        }
    }
}

// MARK: - For StartView to make transition between pages
extension View {
    
    // Navigate to a new view.
    // Parameters: view (View to navigate to), binding (Only navigates when this condition is `true`)
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
