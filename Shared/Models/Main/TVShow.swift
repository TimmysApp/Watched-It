//
//  TVShow.swift
//  Watched It?
//
//  Created by Joe Maghzal on 14/01/2023.
//

import Foundation

struct TVShow: Identifiable, Codable, Equatable {
    var id: Int
//MARK: - Properties
    var adult: Bool
    var backdropPath: URL?
    var createdBy: [Producer]
    var episodeRunTime: [Int]
    var firstAirDate: Date
    var genres: [Genre]
    var homepage: String
    var inProduction: Bool
    var languages: [String]
    var lastAirDate: Date?
    var lastEpisodeToAir: Episode?
    var name: String
    var networks: [NetworkChannel]
    var numberOfEpisodes: Int
    var numberOfSeasons: Int
    var originCountry: [String]
    var originalLanguage: String
    var originalName: String
    var overview: String
    var popularity: Double
    var posterPath: URL?
    var productionCompanies: [ProductionCompany]
    var productionCountries: [ProductionCountry]
    var seasons: [Season]
    var spokenLanguages: [SpokenLanguage]
    var status: String?
    var tagline: String
    var type: String
    var voteAverage: Double
    var voteCount: Int
//MARK: - Mappings
    var duration: String? {
        let runtime = episodeRunTime.reduce(into: 0) { partialResult, item in
            partialResult = item + partialResult
        }/4
        guard runtime > 0 else {
            return nil
        }
        let hours = runtime/60
        let minutes = hours > 1 ? (runtime - (hours * 60)): runtime
        return hours > 1 ? "\(hours)h \(minutes)m": "\(minutes)m"
    }
    var ageRating: String {
        return (adult ? "R": "PG") + " Rated"
    }
}

struct NetworkChannel: Identifiable, Codable, Equatable {
    var name: String
    var id: Int
    var logoPath: URL?
    var originCountry: String
}

struct Season: Identifiable, Codable, Equatable {
    var airDate: Date?
    var episodeCount: Int
    var id: Int
    var name: String
    var overview: String
    var posterPath: URL?
    var seasonNumber: Int
}

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

struct Producer: Identifiable, Codable, Equatable {
    var id: Int
    var creditId: String
    var name: String
    var gender: Gender
    var profilePath: URL?
}

struct SeasonDetails: Codable, Equatable {
    
}
