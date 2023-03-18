//
//  BaseViewConfig.swift
//  Aidie's Club
//
//  Created by Joe Maghzal on 09/03/2023.
//

import Foundation
import Combine

@MainActor open class BaseViewConfig: ObservableObject {
//MARK: - Properties
    @Published internal var routing = RoutingConfig()
    @Published public var isLoading = false
    @Published public var error: Error?
    @Published internal var dismissView = false
    internal var executedTask = false
    public var cancellables = Set<AnyCancellable>()
//MARK: - Functions
    internal func onTask() async {
        guard !executedTask else {return}
        executedTask = true
        Task.detached(priority: .background) { [weak self] in
            await self?.task()
        }
    }
    open func task() async {
    }
    public func dismiss() {
        dismissView.toggle()
    }
    public func route(to sheet: SheetRouter) {
        routing.sheet = sheet
    }
    public func route(to cover: FullScreeCoverRouter) {
        routing.cover = cover
    }
}
