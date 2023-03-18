//
//  PersonCredits.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation

struct PersonCredits<Object: Codable & Equatable>: Identifiable, Codable, Equatable {
    var id: Int
    var cast: [Object]
    var crew: [Object]
}
