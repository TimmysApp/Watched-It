//
//  ImageURL.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation

extension URL {
    static let imageURL = URL(string: "https://image.tmdb.org/t/p")
    var original: URL? {
        return Self.imageURL?
            .appending(path: "original")
            .appending(path: absoluteString)
    }
    var large: URL? {
        return Self.imageURL?
            .appending(path: "w780")
            .appending(path: absoluteString)
    }
    var medium: URL? {
        return Self.imageURL?
            .appending(path: "w342")
            .appending(path: absoluteString)
    }
}
