//
//  Credits.swift
//  Watched It?
//
//  Created by Joe Maghzal on 14/01/2023.
//

import Foundation

struct Credits: Identifiable, Codable, Equatable, Hashable {
    var id: Int
    var cast: [Cast]
    var crew: [Crew]
}
