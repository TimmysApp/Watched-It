//
//  PageableResponse.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation

struct PageableResponse<Object: Codable>: Codable {
    var page: Int
    var results: [Object]
    var totalPages: Int
    var totalResults: Int
}
