//
//  NetworkChannel.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation

struct NetworkChannel: Identifiable, Codable, Equatable {
    var name: String
    var id: Int
    var logoPath: URL?
    var originCountry: String
}
