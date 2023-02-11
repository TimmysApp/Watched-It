//
//  Watched_It_App.swift
//  Watched It?
//
//  Created by Joe Maghzal on 09/01/2023.
//

import SwiftUI
import DataStruct
import NetworkUI
import PhotosUI
import Combine

@main
struct WatchedIt: App {
    static let storage = AppStorage()
    @State var link: MediaPreview.PreviewType?
    init() {
       setUp()
    }
    var body: some Scene {
        WindowGroup {
            RootView(link: $link)
                .environmentObject(NetworkData.shared)
                .handleURL($link)
        }
    }
//MARK: - Functions
    func setUp() {
        UITabBar.appearance().isHidden = true
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        UINavigationBar.appearance().compactScrollEdgeAppearance = navigationBarAppearance
        let toolBarAppearance = UIToolbarAppearance()
        toolBarAppearance.configureWithDefaultBackground()
        UIToolbar.appearance().isHidden = true
        UITextView.appearance().backgroundColor = .clear
        DataConfigurations.setObjectContext(PersistenceController.shared.container.viewContext)
        Network.set(configurations: NetworkLayer())
    }
}
