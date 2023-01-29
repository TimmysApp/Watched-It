//
//  Models.swift
//  Watched It?
//
//  Created by Joe Maghzal on 10/01/2023.
//

import Foundation

public enum DetectionType {
    case face
    case barcode
    case text
}

public enum ImageDetectResult<T> {
    case success([T])
    case notFound
    case failure(Error)
}
