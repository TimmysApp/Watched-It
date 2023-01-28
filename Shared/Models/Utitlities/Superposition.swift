//
//  Superposition.swift
//  Watched It?
//
//  Created by Joe Maghzal on 28/01/2023.
//

import Foundation

typealias Superposable = Codable & Equatable

struct Superposition<Object: Superposable, SecondObject: Superposable>: Identifiable, Codable, Equatable {
//MARK: - Properties
    var id = UUID()
    var firstValue: Object?
    var secondValue: SecondObject?
//MARK: - Initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let object = try? container.decode(Object.self) {
            self.firstValue = object
        }else {
            let object = try container.decode(SecondObject.self)
            self.secondValue = object
        }
    }
}

struct Superposition3<Object: Superposable, SecondObject: Superposable, ThirdObject: Superposable>: Identifiable, Codable, Equatable {
//MARK: - Properties
    var id = UUID()
    var firstValue: Object?
    var secondValue: SecondObject?
    var thirdValue: ThirdObject?
//MARK: - Initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let object = try? container.decode(Object.self) {
            self.firstValue = object
        }else if let object = try? container.decode(SecondObject.self) {
            self.secondValue = object
        }else if let object = try? container.decode(ThirdObject.self) {
            self.thirdValue = object
        }
    }
}
