//
//  IdentifyViewConfig.swift
//  Watched It?
//
//  Created by Joe Maghzal on 09/01/2023.
//

import Foundation

struct IdentifyViewConfig {
//MARK: - Properties
    var identifiedItems = [IdentifiedItem]()
    var mediaItem = MediaItem.empty
    var isPresented = false
//MARK: - Functions
    mutating func togglePin() {
        identifiedItems[0].isPinned.toggle()
        identifiedItems[0].update()
    }
    mutating func tryAgain() {
        isPresented.toggle()
    }
    mutating func performIdentification() async {
        guard !mediaItem.isEmpty else {return}
        let item = IdentifiedItem(isReported: true, isPinned: true, timestamp: Date(), confidence: 9, identifier: "Hello", mediaItem: mediaItem)
        item.save()
//        let result = mediaItem.data.unImage?.detector.crop(type: .face)
//        switch result {
//            case .success(let images):
//            case .failure(let error):
//            default:
//        }
//        guard let item = await ML.identify(using: mediaItem) else {return}
//        identifiedItems.append(item)
    }
}
