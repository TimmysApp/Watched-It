//
//  Images.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation

struct Images: Identifiable, Codable, Equatable {
    //MARK: - Properties
    var id: Int
    var backdrops: [Details]
    var posters: [Details]
    //MARK: - Type
    struct Details: Identifiable, Codable, Equatable {
        var id = UUID()
        var aspectRatio: Double
        var filePath: URL?
        var height: Int
        var iso6391: String?
        var voteAverage: Int
        var voteCount: Int
        var width: Int
    }
}
