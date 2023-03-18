//
//  NetworkLayer.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation
import WatchedItModels
import NetworkUI

struct NetworkLayer: NetworkConfigurations {
    var errorLayer: ErrorConfigurations = ErrorLayer()
    var baseURL: URL? {
        return URL(string: "https://api.themoviedb.org/3/")
    }
    var retryCount: Int {
        return 0
    }
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(JSONDateFormatter())
        return decoder
    }
    func reprocess(url: URL?) -> URL? {
        let route = URLRoute(from: URLQueryItem(name: "api_key", value: Constants.apiKey))
            .appending(URLQueryItem(name: "language", value: "en-US"))
        return route.applied(to: url)
    }
}

struct ErrorLayer: ErrorConfigurations {
}
