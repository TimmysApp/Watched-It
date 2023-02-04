//
//  OptionsViewConfig.swift
//  Watched It?
//
//  Created by Joe Maghzal on 29/01/2023.
//

import Foundation
import DataStruct

struct OptionsViewConfig {
//MARK: - Properties
    var options: MediaOptions?
    var media: MediaPreview?
//MARK: - Functions
    mutating func toggleWatchlist() {
        guard let media else {return}
        if options != nil {
            options?.watchList.toggle()
            options?.update()
        }else {
            let newOptions = MediaOptions(mediaId: media.type.mediaId, isFavorite: false, watchList: true, name: media.title, type: media.type.type, subTitle: media.subTitle ?? "")
            newOptions.save()
            options = newOptions
        }
    }
    mutating func toggleFavorite() {
        guard let media else {return}
        if options != nil {
            options?.isFavorite.toggle()
            options?.update()
        }else {
            let newOptions = MediaOptions(mediaId: media.type.mediaId, isFavorite: true, watchList: false, name: media.title, type: media.type.type, subTitle: media.subTitle ?? "")
            newOptions.save()
            options = newOptions
        }
    }
    mutating func fetch() {
        guard let media else {return}
        options = try? MediaOptions.rawFetch(with: NSPredicate(format: "mediaId == %@ && type == %@", String(media.type.id), media.type.type.rawValue)).first
    }
}
