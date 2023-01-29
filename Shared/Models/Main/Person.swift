//
//  Person.swift
//  Watched It?
//
//  Created by Joe Maghzal on 21/01/2023.
//

import Foundation

struct Person: Identifiable, Codable, Equatable {
    var id: Int
    var adult: Bool
    var name: String
    var alsoKnownAs: [String]?
    var knownForDepartment: String?
    var biography: String?
    var birthday: Date?
    var deathday: Date?
    var gender: Gender?
    var placeOfBirth: String?
    var profilePath: URL?
    var popularity: Double?
    var imdbID: String?
    var homepage: String?
}
