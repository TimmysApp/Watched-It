//
//  Status.swift
//  Watched It?
//
//  Created by Joe Maghzal on 14/01/2023.
//

import Foundation

enum Status: String, Codable {
    case rumored = "Rumored"
    case planned = "Planned"
    case inProduction = "In Production"
    case postProduction = "Post Production"
    case released = "Released"
    case cancelled = "Cancelled"
}
