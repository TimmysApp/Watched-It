//
//  ContentType.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation

enum ContentType: String, Codable, CaseIterable, Identifiable {
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
    var id: String {
        return rawValue
    }
}
