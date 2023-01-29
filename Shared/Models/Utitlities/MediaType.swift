//
//  MediaType.swift
//  Watched It?
//
//  Created by Joe Maghzal on 29/01/2023.
//

import Foundation
import DataStruct

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

//MARK: - DatableValue
extension MediaType: DatableValue {
    var dataValue: Any {
        return rawValue
    }
}
