//
//  Scheme.swift
//  Watched It?
//
//  Created by Joe Maghzal on 28/01/2023.
//

import Foundation

enum Scheme {
    case debug, release
    var url: String {
        switch self {
            case .debug:
                return ""
            case .release:
                return ""
        }
    }
    static var current: Self {
#if Debug
        return .debug
#else
        return .release
#endif
    }
}
