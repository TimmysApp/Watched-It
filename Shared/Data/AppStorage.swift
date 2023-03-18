//
//  File.swift
//  
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation
import WatchedItModels

public enum Storage {
    @Defaults(key: StorageKey.firstLaunch) public static var isFirstLaunch = true
    @Defaults(key: StorageKey.authenticated) public static var isAuthenticated = false
    @Defaults(key: StorageKey.session) public static var authSession: AuthSession? = nil
}

enum StorageKey: String, Stringable {
    case firstLaunch = "FirstLaunch"
    case authenticated = "Authenticated"
    case session = "AuthSession"
    var string: String {
        return rawValue
    }
}
