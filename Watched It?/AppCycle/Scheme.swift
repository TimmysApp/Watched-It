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
                return "http://127.0.0.1:8080/api/v1/"
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
