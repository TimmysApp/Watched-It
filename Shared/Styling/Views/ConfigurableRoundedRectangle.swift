//
//  ConfigurableRoundedRectangle.swift
//  
//
//  Created by Joe Maghzal on 17/03/2023.
//

import SwiftUI

public struct ConfigurableRoundedRectangle: Shape {
    private let corners: UIRectCorner
    private let radius: CGFloat
    public init(corners: UIRectCorner, radius: CGFloat) {
        self.corners = corners
        self.radius = radius
    }
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
