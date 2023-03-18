//
//  Season.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation

struct Season: Identifiable, Codable, Equatable {
    var airDate: Date?
    var episodeCount: Int
    var id: Int
    var name: String
    var overview: String
    var posterPath: URL?
    var seasonNumber: Int
}
