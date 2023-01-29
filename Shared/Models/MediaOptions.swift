//
//  MediaOptions.swift
//  Watched It?
//
//  Created by Joe Maghzal on 29/01/2023.
//

import Foundation
import DataStruct

struct MediaOptions: Identifiable, Codable, Equatable {
    var id: UUID?
    var mediaId: Int
    var isFavorite: Bool
    var watchList: Bool
    var name: String
    var rating: Int?
    var type: MediaType
    var subTitle: String?
}

//MARK: - Datable
extension MediaOptions: Datable {
    static var empty = MediaOptions(mediaId: 0, isFavorite: false, watchList: false, name: "", type: .movie)
    static var modelData = ModelData<MediaOptions>()
    static func map(from object: MediaOptionsData?) -> Self? {
        guard let object, let mediaType = MediaType(rawValue: object.type ?? "") else {
            return nil
        }
        return MediaOptions(id: object.oid, mediaId: Int(object.mediaId), isFavorite: object.isFavorite, watchList: object.watchList, name: object.name ?? "", rating: Int(object.rating), type: mediaType, subTitle: object.subTitle)
    }
}
