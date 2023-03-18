//
//  File.swift
//  
//
//  Created by Joe Maghzal on 17/03/2023.
//

import SwiftUI
import WatchedItModels

public struct RoutingConfig: Equatable {
    internal var sheet: SheetRouter?
    internal var cover: FullScreeCoverRouter?
    public init(sheet: SheetRouter? = nil, cover: FullScreeCoverRouter? = nil) {
        self.sheet = sheet
        self.cover = cover
    }
}

enum NavigationRouter: Hashable, Equatable, ContentPresentable {
    case media(MediaPreview.PreviewType), allContent(MediaPreview.Content)
}

public enum SheetRouter: Identifiable, Equatable, ContentPresentable {
    case movieOptions, confirmPassword(UserCredentials), verifyOTP(UserCredentials), resetPass
    public var id: String {
        switch self {
            case .movieOptions:
                return "0"
            case .confirmPassword:
                return "1"
            case .verifyOTP:
                return "2"
            case .resetPass:
                return "3"
        }
    }
    public static func == (lhs: SheetRouter, rhs: SheetRouter) -> Bool {
        return lhs.id == rhs.id
    }
}

public enum FullScreeCoverRouter: Identifiable, Equatable, ContentPresentable {
    case authentication
    public var id: String {
        switch self {
            case .authentication:
                return "1"
        }
    }
}

public protocol ContentPresentable {
    associatedtype Content: View
    var content: Content {get}
}

public extension ContentPresentable {
    var content: some View {
        return Text("You must have forgotten to set the routed view for \(String(describing: self))")
    }
}
