//
//  RatingViewConfig.swift
//  Watched It?
//
//  Created by Joe Maghzal on 29/01/2023.
//

import Foundation

struct RatingViewConfig {
//MARK: - Properties
    var rating = 0
    var options: MediaOptions?
    var media: MediaPreview?
//MARK: - Functions
    mutating func fetch() {
        guard let media else {return}
        options = try? MediaOptions.rawFetch(with: NSPredicate(format: "mediaId == %@ && type == %@", String(media.type.id), media.type.type.rawValue)).first
        rating = options?.rating ?? 0
    }
    mutating func rate(_ value: Int) {
        guard let media else {return}
        rating = value
        if options != nil {
            options?.rating = value
            options?.update()
        }else {
            let newOptions = MediaOptions(mediaId: media.type.id, isFavorite: false, watchList: false, name: media.title, rating: value, type: media.type.type, subTitle: media.subTitle ?? "")
            newOptions.save()
            options = newOptions
        }
    }
}
