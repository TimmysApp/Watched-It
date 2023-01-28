//
//  DiscoveryRoute.swift
//  Watched It?
//
//  Created by Joe Maghzal on 14/01/2023.
//

import Foundation
import NetworkUI

enum DiscoveryRoute: EndPoint {
    case discover(page: Int, sorting: SortingOption, type: MediaType)
    case trending(page: Int, type: MediaType, time: TimeWindow)
    var route: URLRoute {
        switch self {
            case .discover(let page, let sorting, let type):
                return URLRoute(from: "discover")
                    .appending(type.rawValue)
                    .appending(URLQueryItem(name: "sort_by", value: sorting.rawValue), isPost: true)
                    .appending(URLQueryItem(name: "page", value: String(page)), isPost: true)
            case .trending(let page, let type, let time):
                return URLRoute(from: "trending")
                    .appending(type.rawValue)
                    .appending(time.rawValue)
                    .appending(URLQueryItem(name: "page", value: String(page)), isPost: true)
        }
    }
    
    var method: RequestMethod {
        return .get
    }
    var body: JSON? {
        return nil
    }
}

enum SortingOption: String {
    case popularityAscending = "popularity.asc"
    case popularityDescending = "popularity.desc"
}

enum TimeWindow: String {
    case day = "day"
    case week = "week"
}

enum MediaType: String, Codable {
    case all = "all"
    case movie = "movie"
    case tv = "tv"
    case person = "person"
    var title: String {
        switch self {
            case .all:
                return "All"
            case .movie:
                return "Movies"
            case .tv:
                return "TV Shows"
            case .person:
                return "People"
        }
    }
    var image: String {
        switch self {
            case .all:
                return "All"
            case .movie:
                return "theatermasks.fill"
            case .tv:
                return "tv.fill"
            case .person:
                return "person.fill"
        }
    }
}
