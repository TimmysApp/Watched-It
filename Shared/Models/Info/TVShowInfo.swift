//
//  TVShowInfo.swift
//  Watched It?
//
//  Created by Joe Maghzal on 28/01/2023.
//

import Foundation

struct TVShowInfo: Identifiable, Codable, Equatable {
//MARK: - Properties
    var id: Int
    var genreIds: [Int]
    var adult: Bool?
    var backdropPath: URL?
    var originCountry: [String]
    var popularity: Double
    var posterPath: URL?
    var overview: String
    var firstAirDate: String
    var originalName: String
    var originalLanguage: String
    var voteCount: Int
    var creditId: String?
    var character: String?
    var department: String?
    var job: String?
    var episodeCount: Int?
    var name: String
    var voteAverage: Double
//MARK: - Mappings
    var preview: MediaPreview {
        return MediaPreview(url: posterPath?.medium, title: name, popularity: popularity, subTitle: character ?? job, type: .tvShow(id: id))
    }
}
