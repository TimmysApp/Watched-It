//
//  Videos.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation

struct Videos: Identifiable, Codable, Equatable {
//MARK: - Properties
    var id: Int
    var results: [Video]
//MARK: - Mappings
    var trailer: Video? {
        return results.first(where: {$0.type == .trailer && $0.official})
    }
}

struct Video: Identifiable, Codable, Equatable, Hashable {
//MARK: - Properties
    var id: String
    var iso6391: String
    var iso31661: String
    var name: String
    var key: String
    var site: String
    var size: Int
    var type: VideoType
    var official: Bool
    var publishedAt: String
//MARK: - Types
    enum VideoType: String, Codable, Equatable, Hashable {
        case trailer = "Trailer"
        case teaser = "Teaser"
        case clip = "Clip"
        case openingCredits = "Opening Credits"
        case featurette = "Featurette"
        case behindTheScenes = "Behind the Scenes"
        case bloopers = "Bloopers"
    }
}
