//
//  Gender.swift
//  Watched It?
//
//  Created by Joe Maghzal on 14/01/2023.
//

import Foundation

enum Gender: Int, Codable, Equatable, Hashable {
    case unknown = 0
    case female = 1
    case male = 2
    case other = 3
    var title: String {
        switch self {
            case .unknown:
                return "Unknown"
            case .female:
                return "Female"
            case .male:
                return "Male"
            case .other:
                return "Other"
        }
    }
}
