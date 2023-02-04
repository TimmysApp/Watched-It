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
                    .tabItem {
                        Text(tab.title)
                        Image(systemName: tab.icon)
                    }.tag(tab)
            }
        }.accentColor(.tint)
        .fullScreenCover(item: $link) { item in
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
