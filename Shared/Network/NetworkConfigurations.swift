//
//  NetworkConfigurations.swift
//  Watched It?
//
//  Created by Joe Maghzal on 13/01/2023.
//

import Foundation
import WatchedItModels
import NetworkUI

class NetworkLayer: NetworkConfigurations {
    var errorLayer: ErrorConfigurations = ErrorLayer()
    var baseURL: URL? {
        return URL(string: "https://api.themoviedb.org/3/")
    }
    var retryCount: Int {
        return 1
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

class ErrorLayer: ErrorConfigurations {
}

struct ErrorData: Errorable {
    var id = UUID()
    var networkError: NetworkError {
        NetworkError(title: message, body: summary)
    }
    var message: String?
    var summary: String?
    var action: Actions?
    enum CodingKeys: CodingKey {
        case message, summary, action
    }
}

class JSONDateFormatter: DateFormatter {
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    override func date(from string: String) -> Date? {
        if let date = dateFormatter.date(from: string) {
            return date
        }else {
            return Date()
        }
    }
}
