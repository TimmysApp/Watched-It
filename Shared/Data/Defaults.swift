//
//  Defaults.swift
//  
//
//  Created by Joe Maghzal on 17/03/2023.
//

import Foundation
import SwiftUI

@propertyWrapper public struct Defaults<Value: Codable, Key: Stringable>: DynamicProperty {
    @AppStorage("") private var defaultsData: Data?
    private let key: String
    private let defaultValue: Value
    private let storage = UserDefaults.combined
    public init(wrappedValue defaultValue: Value, key: Key) {
        self._defaultsData = AppStorage(key.string, store: storage)
        self.defaultValue = defaultValue
        self.key = key.string
    }
    public var wrappedValue: Value {
        get {
            guard let data = defaultsData else {
                return defaultValue
            }
            if let dataValue = data as? Value {
                return dataValue
            }
            return (try? JSONDecoder().decode(Value.self, from: data)) ?? defaultValue
        }
        nonmutating set {
            if let oldData = storage.data(forKey: key) {
                storage.set(oldData, forKey: key + "Old")
            }
            if let dataValue = newValue as? Data {
                defaultsData = dataValue
            }else {
                guard let data = try? JSONEncoder().encode(newValue) else {return}
                defaultsData = data
            }
        }
    }
    public var oldValue: Value {
        get {
            guard let data = storage.data(forKey: key + "Old") else {
                return defaultValue
            }
            if let dataValue = data as? Value {
                return dataValue
            }
            return (try? JSONDecoder().decode(Value.self, from: data)) ?? defaultValue
        }
    }
    public var projectedValue: Binding<Value> {
        return Binding {
            return wrappedValue
        } set: { newValue, _ in
            wrappedValue = newValue
        }
    }
}

public protocol Stringable {
    var string: String {get}
}

public extension UserDefaults {
    static var combined: UserDefaults {
        let combined = UserDefaults.standard
        combined.addSuite(named: "group.watch-it.data")
        return combined
    }
}
