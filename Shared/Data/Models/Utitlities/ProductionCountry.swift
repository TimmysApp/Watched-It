//
//  ProductionCountry.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation

struct ProductionCountry: Identifiable, Codable, Equatable {
    var id: String {
        return iso31661
    }
    var iso31661: String
    var name: String
}
