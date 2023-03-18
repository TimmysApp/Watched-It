//
//  Episode.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation

struct Episode: Identifiable, Codable, Equatable {
    var airDate: Date
    var episodeNumber: Int
    var id: Int
    var name: String
    var overview: String
    var productionCode: String
    var seasonNumber: Int
    var stillPath: URL?
    var voteAverage: Double
    var voteCount: Int
}
