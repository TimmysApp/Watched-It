//
//  TabPage.swift
//  Watch It!
//
//  Created by Joe Maghzal on 17/03/2023.
//

import SwiftUI

enum TabPage: Int, CaseIterable, Identifiable {
    case home, watchIt, community, prefrences
    var title: String {
        switch self {
            case .home:
                return "Home"
            case .watchIt:
                return "Watch It"
            case .community:
                return "Community"
            case .prefrences:
                return "Prefrences"
        }
    }
    var image: String {
        switch self {
            case .home:
                return "house.fill"
            case .watchIt:
                return "play.circle.fill"
            case .community:
                return "person.3.fill"
            case .prefrences:
                return "gearshape.fill"
        }
    }
    var id: Int {
        return rawValue
    }
    var color: Color {
        switch self {
            case .home:
                return .greeny
            case .watchIt:
                return .redy
            case .community:
                return .bluey
            case .prefrences:
                return .gray
        }
    }
    @ViewBuilder var content: some View {
        switch self {
            case .home:
                HomeView()
            case .watchIt:
                Text("")
            case .community:
                Text("")
            case .prefrences:
                Text("")
        }
    }
}
