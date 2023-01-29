//
//  RootViewConfig.swift
//  Watched It?
//
//  Created by Joe Maghzal on 09/01/2023.
//

import Foundation

struct RootViewConfig {
    var selectedTab = RootTab.identify
}

enum RootTab: Int, CaseIterable, Identifiable {
    case recents, identify, vycover, discover, prefrences
    var title: String {
        switch self {
            case .recents:
                return "Recents"
            case .identify:
                return "Identify"
            case .vycover:
                return "VyCover"
            case .discover:
                return "Discover"
            case .prefrences:
                return "Prefrences"
        }
    }
    var icon: String {
        switch self {
            case .recents:
                return "clock.fill"
            case .identify:
                return "viewfinder"
            case .vycover:
                return "play.circle.fill"
            case .discover:
                return "doc.text.magnifyingglass"
            case .prefrences:
                return "gearshape.fill"
        }
    }
    var id: Int {
        return rawValue
    }
}
