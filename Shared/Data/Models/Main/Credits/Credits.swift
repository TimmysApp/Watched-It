//
//  Credits.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation

struct Credits: Identifiable, Codable, Equatable, Hashable {
    var id: Int
    var cast: [Cast]
    var crew: [Crew]
}
