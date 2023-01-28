//
//  MediaItem.swift
//  Watched It?
//
//  Created by Joe Maghzal on 09/01/2023.
//

import Foundation
import MediaUI
import DataStruct

struct MediaItem: Mediable, Codable {
//MARK: - Properties
    var id: UUID?
    var data: Data
    var timestamp: Date
    static var empty = MediaItem(data: Data(), timestamp: Date())
//MARK: - Mappings
    var isEmpty: Bool {
        return self == .empty
    }
}

//MARK: - Datable
extension MediaItem: Datable {
    static var modelData = ModelData<MediaItem>()
    static func map(from object: MediaItemData?) -> MediaItem? {
        guard let object else {return nil}
        return MediaItem(id: object.oid, data: object.data ?? Data(), timestamp: object.timestamp ?? Date())
    }
}
