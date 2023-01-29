//
//  ProductionCompany.swift
//  Watched It?
//
//  Created by Joe Maghzal on 14/01/2023.
//

import Foundation

struct ProductionCompany: Identifiable, Codable, Equatable {
    var id: Int
    var name: String
    var originCountry: String
    var logoPath:  URL?
}
