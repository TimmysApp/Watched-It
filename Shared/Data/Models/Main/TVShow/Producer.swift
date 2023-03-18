//
//  Producer.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation

struct Producer: Identifiable, Codable, Equatable {
    var id: Int
    var creditId: String
    var name: String
    var gender: Gender
    var profilePath: URL?
}
