//
//  TVShowRoute.swift
//  Watched It?
//
//  Created by Joe Maghzal on 16/01/2023.
//

import Foundation
import NetworkUI

enum TVShowRoute: EndPoint {
    case details(id: Int)
    case credits(id: Int)
    case images(id: Int)
    case recomendations(id: Int)
    case reviews(id: Int)
    case videos(id: Int)
    case providers(id: Int)
    case upcoming
    var route: URLRoute {
        return URLRoute(from: "tv")
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
                    case .reviews:
                        return "reviews"
                    case .videos:
                        return "videos"
                    case .upcoming:
                        return "upcoming"
                    case .providers:
                        return "videos"
                        //                        return URLRoute(from: "watch")
                        //                            .appending("providers")
                }
            }
    }
    
    var method: RequestMethod {
        return .GET
    }
    var id: String {
        switch self {
            case .details(let id), .credits(let id), .images(let id), .recomendations(let id), .reviews(let id), .videos(let id), .providers(let id):
                return String(id)
            default:
                return ""
        }
    }
}
