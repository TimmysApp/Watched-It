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
        return .GET
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
