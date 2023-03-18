//
//  Status.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
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
