//
//  ContentView.swift
//  Watch It!
//
//  Created by Joe Maghzal on 17/03/2023.
//

import SwiftUI

struct RootView: View {
    @State var selectedPage = TabPage.home
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedPage) {
                ForEach(TabPage.allCases) { page in
                    page.content
                        .tag(page)
                }
            }.padding(.bottom, -80)
            TabBarView(selectedPage: $selectedPage)
        }.edgesIgnoringSafeArea(.bottom)
    }
}
