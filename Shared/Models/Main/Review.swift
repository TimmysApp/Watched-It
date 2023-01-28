//
//  Review.swift
//  Watched It?
//
//  Created by Joe Maghzal on 14/01/2023.
//

import Foundation

struct Review: Identifiable, Codable, Equatable {
    var id: String
    var author: String
    var authorDetails: AuthorDetails
    var content: String
    var createdAt: Date
    var updatedAt: Date
    var url: String
}

struct AuthorDetails: Codable, Equatable {
    var name: String
    var username: String
    var avatarPath: URL?
    var rating: Int?
}
