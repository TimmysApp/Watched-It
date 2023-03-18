//
//  PersonInfo.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation

struct PersonInfo: Identifiable, Codable, Equatable {
    var id: Int
    var profilePath: URL?
    var adult: Bool?
    var name: String
    var popularity: Double
}
