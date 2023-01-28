//
//  ConfigurableRoundedRectangle.swift
//  Watched It?
//
//  Created by Joe Maghzal on 21/01/2023.
//

import SwiftUI

struct ConfigurableRoundedRectangle: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
