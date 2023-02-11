//
//  AppStorage.swift
//  Watched It?
//
//  Created by Joe Maghzal on 04/02/2023.
//

import Foundation
import WatchedItModels

struct AppStorage {
    @Storage(key: .firstLaunch) var isFirstLaunch = true
    @Storage(key: .authenticated) var isAuthenticated = false
    @Storage(key: .session) var authSession: AuthSession? = nil
}

@propertyWrapper struct Storage<T: Codable> {
    let key: String
    let defaultValue: T
    init(wrappedValue defaultValue: T, key: StorageKey) {
        self.key = key.rawValue
        self.defaultValue = defaultValue
    }
    var wrappedValue: T {
        get {
            let decoder = JSONDecoder()
            guard let data = UserDefaults.standard.data(forKey: key) else {
                return defaultValue
            }
            return (try? decoder.decode(T.self, from: data)) ?? defaultValue
        }
        nonmutating set {
            if let oldData = UserDefaults.standard.data(forKey: key) {
                UserDefaults.standard.set(oldData, forKey: key + "Old")
            }
            let encoder = JSONEncoder()
            guard let data = try? encoder.encode(newValue) else {return}
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    var projectedValue: T {
        get {
            let decoder = JSONDecoder()
            guard let data = UserDefaults.standard.data(forKey: key + "Old") else {
                return defaultValue
            }
            return (try? decoder.decode(T.self, from: data)) ?? defaultValue
        }
    }
}

enum StorageKey: String {
    case firstLaunch = "FirstLaunch"
    case authenticated = "Authenticated"
    case session = "AuthSession"
}
