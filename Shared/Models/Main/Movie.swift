//
//  MovieDetails.swift
//  Watched It?
//
//  Created by Joe Maghzal on 14/01/2023.
//

import Foundation

struct Movie: Identifiable, Codable, Equatable {
//MARK: - Properties
    var id: Int
    var adult: Bool
    var backdropPath:  URL?
    var budget: Int
    var genres: [Genre]
    var homepage: String?
    var imdbId: String?
    var originalLanguage: String
    var originalTitle: String
    var overview: String?
    var popularity: Double
    var posterPath:  URL?
    var productionCompanies: [ProductionCompany]
    var productionCountries: [ProductionCountry]
    var releaseDate: Date
    var revenue: Int
    var runtime: Int?
    var spokenLanguages: [SpokenLanguage]
    var status: Status
    var tagline: String?
    var title: String
    var video: Bool
    var voteAverage: Double
    var voteCount: Int
//MARK: - Mappings
    var preview: MediaPreview {
        return MediaPreview(url: backdropPath?.large, title: title, popularity: popularity, subTitle: tagline, type: .movie(id: id))
    }
    var duration: String? {
        guard let runtime else {return nil}
        let hours = runtime/60
        let minutes = runtime - (hours * 60)
        return "\(hours)h \(minutes)m"
    }
    var ageRating: String {
        return (adult ? "R": "PG") + " Rated"
    }
}
