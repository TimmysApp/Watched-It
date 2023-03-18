//
//  Watch_It_App.swift
//  Watch It!
//
//  Created by Joe Maghzal on 17/03/2023.
//

import SwiftUI
import NetworkUI

@main
struct WatchItApp: App {
    init() {
        setUp()
    }
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
//MARK: - Functions
    func setUpAppearances() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITextView.appearance().backgroundColor = .clear
        UICollectionView.appearance().backgroundColor = .clear
        UICollectionViewCell.appearance().backgroundColor = .clear
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont.rounded(size: .body, weight: .semibold)]
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont.rounded(size: .largeTitle, weight: .bold)]
        UITableView.appearance().backgroundColor = .clear
    }
    func setUpBars() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        UINavigationBar.appearance().compactScrollEdgeAppearance = navigationBarAppearance
        let toolBarAppearance = UIToolbarAppearance()
        toolBarAppearance.configureWithDefaultBackground()
        UIToolbar.appearance().scrollEdgeAppearance = toolBarAppearance
    }
    func setUp() {
        Network.set(configurations: NetworkLayer())
//        DataConfigurations.setObjectContext(persistenceController.container.viewContext)
        setUpAppearances()
        setUpBars()
//        ConnectionListener.reachability = try? Reachability(hostname: Scheme.current.url)
    }
}
