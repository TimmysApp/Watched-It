//
//  ExpandableView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 04/02/2023.
//

import SwiftUI
import STools

struct ExpandableView<Content: View>: View {
    @Environment(\.isEnabled) var isEnabled
    let content: Content
    let withExtension: Bool
    let background: AnyShapeStyle?
    var body: some View {
        content
            .stateModifier(isEnabled && withExtension) { view in
                view
                    .center(.horizontal)
            }.stateModifier(background != nil) { view in
                view
                    .background(background!)
            }.opacity(isEnabled ? 1: 0.5)
//            .transition(.scale)
    }
    func backgroundy<Content: ShapeStyle>(@ViewBuilder content: @escaping () -> Content) -> some View {
        return ExpandableView(content: self.content, withExtension: withExtension, background: AnyShapeStyle(content()))
    }
    func backgroundy<Contenty: ShapeStyle>(_ content: Contenty) -> some View {
        return ExpandableView(content: self.content, withExtension: withExtension, background: AnyShapeStyle(content))
    }
}

extension View {
    func expandable(withExtension: Bool = false) -> ExpandableView<Self> {
        ExpandableView(content: self, withExtension: withExtension, background: nil)
    }
}
