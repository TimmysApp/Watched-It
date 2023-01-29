//
//  Croppable.swift
//  Watched It?
//
//  Created by Joe Maghzal on 10/01/2023.
//

import SwiftUI

public protocol Croppable {
}

public extension Croppable {
    var detector: ImageDetect<Self> {
        return ImageDetect(self)
    }
}

extension NSObject: Croppable {}
extension CGImage: Croppable {}
