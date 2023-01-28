//
//  MediaPreview.swift
//  Watched It?
//
//  Created by Joe Maghzal on 15/01/2023.
//

import Foundation

struct MediaPreview: Identifiable, Equatable, Hashable {
//MARK: - Properties
    var id = UUID()
    var url: URL?
    var title: String
    var popularity: Double
    var subTitle: String?
    var type: PreviewType
//MARK: - Types
    enum PreviewType: Equatable, Hashable {
        case movie(id: Int)
        case tvShow(id: Int)
        case person(id: Int)
        var type: MediaType {
            switch self {
                case .movie:
                    return .movie
                case .tvShow:
                    return .tv
                case .person:
                    return .person
            }
        }
        var id: Int {
            switch self {
                case .movie(let mediaID), .tvShow(let mediaID), .person(let mediaID):
                    return mediaID
            }
        }
        var image: String {
            switch self {
                case .person:
                    return "person.fill"
                case .movie:
                    return "theatermasks.fill"
                case .tvShow:
                    return "tv.fill"
            }
        }
    }
    enum Content: Identifiable, Equatable, Hashable {
        case trending(movies: [MediaPreview], shows: [MediaPreview])
        case popular(movies: [MediaPreview], shows: [MediaPreview])
        case upcoming(movies: [MediaPreview], shows: [MediaPreview])
        var id: Int {
            switch self {
                case .trending:
                    return 0
                case .popular:
                    return 1
                case .upcoming:
                    return 2
            }
        }
        var title: String {
            switch self {
                case .trending:
                    return "Trending"
                case .popular:
                    return "Popular"
                case .upcoming:
                    return "Upcoming"
            }
        }
        var movies: [MediaPreview] {
            switch self {
                case .trending(let movies, _):
                    return movies
                case .popular(let movies, _):
                    return movies
                case .upcoming(let movies, _):
                    return movies
            }
        }
        var tvShows: [MediaPreview] {
            switch self {
                case .trending(_, let tvShows):
                    return tvShows
                case .popular(_, let tvShows):
                    return tvShows
                case .upcoming(_, let tvShows):
                    return tvShows
            }
        }
        func with(type: MediaType) -> Self {
            switch self {
                case .trending(let movies, let shows):
                    return .trending(movies: type == .movie ? movies: [], shows: type == .tv ? shows: [])
                case .popular(let movies, let shows):
                    return .popular(movies: type == .movie ? movies: [], shows: type == .tv ? shows: [])
                case .upcoming(let movies, let shows):
                    return .upcoming(movies: type == .movie ? movies: [], shows: type == .tv ? shows: [])
            }
        }
    }
}
