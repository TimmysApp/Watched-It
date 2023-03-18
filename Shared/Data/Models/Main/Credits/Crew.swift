//
//  Crew.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation

struct Crew: Identifiable, Codable, Equatable, Hashable {
//MARK: - Properties
    var adult: Bool
    var gender: Gender?
    var id: Int
    var knownForDepartment: String
    var name: String
    var originalName: String
    var popularity: Double
    var profilePath:  URL?
    var creditId: String
    var department: String
    var job: String
//MARK: - Mappings
    var preview: CreditsPreview {
        return CreditsPreview(name: name, job: job, department: knownForDepartment, url: profilePath?.medium, type: .crew(id: id))
    }
}
