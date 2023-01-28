//
//  IdentifiedItem.swift
//  Watched It?
//
//  Created by Joe Maghzal on 09/01/2023.
//

import Foundation
import DataStruct

struct IdentifiedItem: Identifiable, Codable, Equatable {
//MARK: - Properties
    var id: UUID?
    var isReported: Bool
    var isPinned: Bool
    var timestamp: Date
    var confidence: Double
    var identifier: String
    var mediaItem: MediaItem?
//MARK: - Mappings
    var confidencePercent: Double {
        return Double(round(1000 * confidence)/1000)
    }
}

//MARK: - Datable
extension IdentifiedItem: Datable {
    static var empty = IdentifiedItem(isReported: false, isPinned: false, timestamp: Date(), confidence: 0, identifier: "", mediaItem: .empty)
    static var modelData = ModelData<IdentifiedItem>()
    static func map(from object: IdentifiedItemData?) -> IdentifiedItem? {
        guard let object else {return nil}
        return IdentifiedItem(id: object.oid, isReported: object.isReported, isPinned: object.isPinned, timestamp: object.timestamp ?? Date(), confidence: object.confidence, identifier: object.identifier ?? "", mediaItem: MediaItem.map(from: object.mediaItem))
    }
}
