//
//  BaseView.swift
//  
//
//  Created by Joe Maghzal on 17/03/2023.
//

import SwiftUI
import STools
import Combine

public protocol BaseView: View {
    associatedtype BodyContent: View
    associatedtype BodyConfig: BaseViewConfig
    @ViewBuilder var content: BodyContent {get}
    var config: BodyConfig {get}
    var withRouting: Bool {get}
}

public extension BaseView {
    @ViewBuilder var body: some View {
        if content as? Navigationable != nil {
            NavigationStack {
                content.body
                    .modifier(BaseViewModifier(config: config, withRouting: withRouting))
            }
        }else {
            content
                .modifier(BaseViewModifier(config: config, withRouting: withRouting))
        }
    }
    var withRouting: Bool {
        return true
    }
}

public struct BaseViewModifier<Config: BaseViewConfig>: ViewModifier {
    @ObservedObject internal var config: Config
    @Environment(\.dismiss) internal var dismiss
    internal let withRouting: Bool
    public func body(content: Content) -> some View {
        content
            .showLoading(config.isLoading)
            .stateModifier(withRouting) { view in
                view
                    .routed(using: $config.routing)
            }.task(priority: .background) {
                await config.onTask()
            }.onChange(of: config.dismissView) { _ in
                dismiss.callAsFunction()
            }.onChange(of: config.routing.cover) { newValue in
                guard newValue == nil else {return}
                Task.detached(priority: .background) {
                    await config.task()
                }
            }.onChange(of: config.routing.sheet) { newValue in
                guard newValue == nil else {return}
                Task.detached(priority: .background) {
                    await config.task()
                }
            }
    }
}

public struct NavigationStackView<Content: View>: View, Navigationable {
    @ViewBuilder public var content: Content
    public var body: some View {
        content
    }
}

internal protocol Navigationable {
}
