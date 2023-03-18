//
//  MediaPreview.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation
import NetworkUI

struct MediaPreview: Identifiable, Equatable, Hashable {
//MARK: - Properties
    var id = UUID()
    var url: URL?
    var title: String
    var popularity: Double
    var subTitle: String?
    var type: PreviewType
//MARK: - Types
    enum PreviewType: Equatable, Hashable, Identifiable {
        case movie(id: Int)
        case tvShow(id: Int)
        case person(id: Int)
        var type: ContentType {
            switch self {
                case .movie:
                    return .movie
                case .tvShow:
                    return .tv
                case .person:
                    return .person
            }
        }
        var mediaId: Int {
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
        var id: String {
            return image + String(mediaId)
        }
        init?(type: String, id: Int) {
            let type = ContentType(rawValue: type)
            switch type {
                case .movie:
                    self = .movie(id: id)
                case .tv:
                    self = .tvShow(id: id)
                case .person:
                    self = .person(id: id)
                default:
                    return nil
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
        var type: MediaType {
            switch self {
                case .trending(let movies, _), .popular(let movies, _), .upcoming(let movies, _):
                    return movies.isEmpty ? .tv: .movie
            }
        }
        func route(page: Int) -> Route {
            switch self {
                case .trending:
                    return DiscoveryRoute.trending(page: page, type: type, time: .day)
                case .popular:
                    return DiscoveryRoute.discover(page: page, sorting: .popularityDescending, type: type)
                case .upcoming:
                    return MovieRoute.upcoming
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
