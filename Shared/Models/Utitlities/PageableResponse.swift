//
//  PageableResponse.swift
//  Watched It?
//
//  Created by Joe Maghzal on 14/01/2023.
//

import Foundation

struct PageableResponse<Object: Codable>: Codable {
    var page: Int
    var results: [Object]
    var totalPages: Int
    var totalResults: Int
}
