//
//  File.swift
//  
//
//  Created by Joe Maghzal on 17/03/2023.
//

import SwiftUI

public extension Font {
    static func rounded(size: RoundedSize = .body, weight: RoundedWeight? = nil) -> Font {
        return Font.custom("SFProRounded\(weight == nil ? "": "-\(weight?.rawValue ?? "")")", size: size.size)
    }
}

public extension UIFont {
    static func rounded(size: RoundedSize, weight: RoundedWeight? = nil) -> UIFont {
        return UIFont(name: "SFProRounded\(weight == nil ? "": "-\(weight?.rawValue ?? "")")", size: size.size)!
    }
}

public extension View {
    func roundedFont(_ size: RoundedSize = .body, weight: RoundedWeight = .regular) -> some View {
        font(.rounded(size: size, weight: size.weight ?? weight))
    }
}

public extension View where Self == Text {
    func roundedFont(_ size: RoundedSize = .body, weight: RoundedWeight = .regular) -> Self {
        font(.rounded(size: size, weight: size.weight ?? weight))
    }
}

public enum RoundedWeight: String {
    case black = "Black"
    case heavy = "Heavy"
    case bold = "Bold"
    case semibold = "Semibold"
    case medium = "Medium"
    case regular = "Regular"
    case light = "Light"
    case thin = "Thin"
    case ultralight = "Ultralight"
}

public enum RoundedSize {
    ///Font Size: 34
    case largeTitle
    ///Font Size: 28
    case title
    ///Font Size: 22
    case title2
    ///Font Size: 20
    case title3
    ///Font Size: 17, Font Weight: SemiBold
    case headline
    ///Font Size: 15
    case subheadline
    ///Font Size: 17
    case body
    ///Font Size: 16
    case callout
    ///Font Size: 13
    case footnote
    ///Font Size: 12
    case caption
    ///Font Size: 111
    case caption2
    case custom(CGFloat)
    public var size: CGFloat {
        switch self {
            case .largeTitle:
                return 34
            case .title:
                return 28
            case .title2:
                return 22
            case .title3:
                return 20
            case .headline:
                return 17
            case .subheadline:
                return 15
            case .body:
                return 17
            case .callout:
                return 16
            case .footnote:
                return 13
            case .caption:
                return 12
            case .caption2:
                return 11
            case .custom(let size):
                return size
        }
    }
    public var weight: RoundedWeight? {
        switch self {
            case .headline:
                return .semibold
            default:
                return nil
        }
    }
}
