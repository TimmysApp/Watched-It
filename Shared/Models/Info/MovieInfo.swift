//
//  MovieInfo.swift
//  Watched It?
//
//  Created by Joe Maghzal on 28/01/2023.
//

import Foundation

struct MovieInfo: Identifiable, Codable, Equatable {
//MARK: - Properties
    var id: Int
    var genreIds: [Int]
    var adult: Bool?
    var backdropPath: URL?
    var originalTitle: String
    var voteAverage: Double
    var popularity: Double
    var posterPath: URL?
    var overview: String
    var title: String
    var order: Int?
    var originalLanguage: String
    var voteCount: Int
    var creditId: String?
    var releaseDate: String
    var character: String?
    var video: Bool
    var department: String?
    var job: String?
//MARK: - Mappings
    var preview: MediaPreview {
        return MediaPreview(url: posterPath?.medium, title: title, popularity: popularity, subTitle: character ?? job, type: .movie(id: id))
    }
}
