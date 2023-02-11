//
//  ContentView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 09/01/2023.
//

import SwiftUI
import CoreData
import NetworkUI

struct RootView: View {
    @Binding var link: MediaPreview.PreviewType?
    @State var config = RootViewConfig()
    var body: some View {
        TabView(selection: $config.selectedTab) {
            ForEach(RootTab.allCases) { tab in
                tab.view
                    .toolbar(.hidden, for: .tabBar)
                    .tag(tab)
            }
        }.accentColor(.tint)
        .overlay(alignment: .bottom) {
            TabBarView(selection: $config.selectedTab)
        }.fullScreenCover(item: $link) { item in
            LinkView(link: item)
        }
    }
}

extension RootTab {
    @ViewBuilder var view: some View {
        switch self {
            case .recents:
                RecentsView()
            case .identify:
                IdentifyView()
            case .vycover:
                Text("")
            case .discover:
                DiscoverView()
            case .prefrences:
                PrefrencesView()
        }
    }
}
