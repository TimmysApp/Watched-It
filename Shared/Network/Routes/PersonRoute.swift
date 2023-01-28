//
//  PersonRoute.swift
//  Watched It?
//
//  Created by Joe Maghzal on 21/01/2023.
//

import Foundation
import NetworkUI

enum PersonRoute: EndPoint {
    case details(id: Int)
    case movieCredits(id: Int)
    case tvShowCredits(id: Int)
    case images(id: Int)
    case externalIDs(id: Int)
    var route: URLRoute {
        return URLRoute(from: "person")
            .appending(id)
            .appending {
                switch self {
                    case .details:
                        return nil
                    case .movieCredits:
                        return "movie_credits"
                    case .tvShowCredits:
                        return "tv_credits"
                    case .images:
                        return "images"
                    case .externalIDs:
                        return "external_ids"
                }
            }
    }
    
    var method: RequestMethod {
        return .get
    }
    var body: JSON? {
        return nil
    }
    var id: String {
        switch self {
            case .details(let id), .movieCredits(let id), .tvShowCredits(let id), .images(let id), .externalIDs(let id):
                return String(id)
        }
    }
}
