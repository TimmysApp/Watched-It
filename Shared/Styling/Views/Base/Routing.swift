//
//  File.swift
//  
//
//  Created by Joe Maghzal on 17/03/2023.
//

import SwiftUI

public struct RoutersModifier<Config: BaseViewConfig>: ViewModifier {
    @Binding public var config: RoutingConfig
    public func body(content: Content) -> some View {
        content
            .navigationDestination(for: NavigationRouter.self) { destination in
                destination.content
            }.sheet(item: $config.sheet) { item in
                item.content
            }.fullScreenCover(item: $config.cover) { item in
                item.content
            }
    }
}

public extension View {
    func routed(using config: Binding<RoutingConfig> = .constant(RoutingConfig())) -> some View {
        modifier(RoutersModifier(config: config))
    }
}
