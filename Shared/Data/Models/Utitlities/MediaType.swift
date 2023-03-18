//
//  MediaType.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation
//import DataStruct

enum MediaType: String, Codable, CaseIterable, Identifiable {
    case all = "all"
    case movie = "movie"
    case tv = "tv"
    var title: String {
        switch self {
            case .all:
                return "All"
            case .movie:
                return "Movies"
            case .tv:
                return "TV Shows"
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
        }
    }
    var id: String {
        return rawValue
    }
}

////MARK: - DatableValue
//extension MediaType: DatableValue {
//    var dataValue: Any {
//        return rawValue
//    }
//}
