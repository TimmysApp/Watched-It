//
//  MovieRoute.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation
import NetworkUI

enum MovieRoute: Route {
    case details(id: Int)
    case credits(id: Int)
    case images(id: Int)
    case recomendations(id: Int)
    case reviews(id: Int, page: Int)
    case videos(id: Int)
    case providers(id: Int)
    case upcoming
    var route: URLRoute {
        return URLRoute(from: "movie")
            .appending(id)
            .appending {
                switch self {
                    case .details:
                        return nil
                    case .credits:
                        return "credits"
                    case .images:
                        return "images"
                    case .recomendations:
                        return "recommendations"
                    case .reviews(_, let page):
                        return URLRoute(from: "reviews")
                            .appending(URLQueryItem(name: "page", value: String(page)), isPost: true)
                    case .videos:
                        return "videos"
                    case .upcoming:
                        return "upcoming"
                    case .providers:
                        return URLRoute(from: "watch")
                            .appending("providers")
                }
            }
    }
    
    var method: RequestMethod {
        return .GET
    }
    var id: String {
        switch self {
            case .details(let id), .credits(let id), .images(let id), .recomendations(let id), .reviews(let id, _), .videos(let id), .providers(let id):
                return String(id)
            default:
                return ""
        }
    }
}
