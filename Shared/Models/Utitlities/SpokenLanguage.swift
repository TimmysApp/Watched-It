//
//  SpokenLanguage.swift
//  Watched It?
//
//  Created by Joe Maghzal on 14/01/2023.
//

import Foundation

struct SpokenLanguage: Identifiable, Codable, Equatable {
    var id: String {
        return iso6391
    }
    var iso6391: String
    var name: String
}
