//
//  SearchRoute.swift
//  Watched It?
//
//  Created by Joe Maghzal on 13/01/2023.
//

import Foundation
import NetworkUI

enum SearchRoute: EndPoint {
    case movies(page: Int, searchText: String, adult: Bool)
    case multi(page: Int, searchText: String, adult: Bool)
    case people(page: Int, searchText: String, adult: Bool)
    case tvShows(page: Int, searchText: String, adult: Bool)
    var route: URLRoute {
        return URLRoute(from: "search")
            .appending {
                switch self {
                    case .movies:
                        return "movie"
                    case .multi:
                        return "multi"
                    case .people:
                        return "person"
                    case .tvShows:
                        return "tv"
                }
            }.appending(URLQueryItem(name: "query", value: searchText), isPost: true)
            .appending(URLQueryItem(name: "page", value: String(page)), isPost: true)
            .appending(URLQueryItem(name: "include_adult", value: String(adult)), isPost: true)
    }
    
    var method: RequestMethod {
        return .get
    }
    var body: JSON? {
        return nil
    }
    var page: Int {
        switch self {
            case .movies(let page, _, _), .multi(let page, _, _), .people(let page, _, _), .tvShows(let page, _, _):
                return page
        }
    }
    var adult: Bool {
        switch self {
            case .movies(_, _, let adult), .multi(_, _, let adult), .people(_, _, let adult), .tvShows(_, _, let adult):
                return adult
        }
    }
    var searchText: String {
        switch self {
            case .movies(_, let searchText, _), .multi(_, let searchText, _), .people(_, let searchText, _), .tvShows(_, let searchText, _):
                return searchText
        }
    }
}
