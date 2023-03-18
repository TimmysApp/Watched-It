//
//  Cast.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation

struct Cast: Identifiable, Codable, Equatable, Hashable {
//MARK: - Properties
    var adult: Bool
    var gender: Gender?
    var id: Int
    var knownForDepartment: String
    var name: String
    var originalName: String
    var popularity: Double
    var profilePath: URL?
    var castId: Int?
    var character: String
    var creditId: String
    var order: Int
//MARK: - Mappings
    var preview: CreditsPreview {
        return CreditsPreview(name: name, job: character, department: knownForDepartment, url: profilePath?.medium, type: .cast(id: id))
    }
}
