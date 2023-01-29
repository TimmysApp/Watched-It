//
//  TrendingMovie.swift
//  Watched It?
//
//  Created by Joe Maghzal on 14/01/2023.
//

import Foundation

struct MediaDetails: Identifiable, Codable, Equatable {
//MARK: - Properties
    var posterPath: URL?
    var adult: Bool?
    var overview: String
    var releaseDate: Date?
    var firstAirDate: Date?
    var genreIds: [Int]
    var originCountry: [String]?
    var id: Int
    var originalTitle: String?
    var originalName: String?
    var originalLanguage: String
    var title: String?
    var name: String?
    var backdropPath: URL?
    var popularity: Double
    var voteCount: Double
    var video: Bool?
    var voteAverage: Double
    var mediaType: MediaType?
//MARK: - Mappings
    var preview: MediaPreview {
        return MediaPreview(url: posterPath?.medium, title: name ?? title ?? "N/A", popularity: popularity, type: mediaType == .movie ? .movie(id: id): .tvShow(id: id))
    }
    func with(type: MediaType) -> Self {
        var toReturn = self
        toReturn.mediaType = type
        return toReturn
    }
}
