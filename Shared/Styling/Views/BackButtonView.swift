//
//  BackButtonView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 15/01/2023.
//

import SwiftUI

public struct BackButtonView: View {
    private var closeStyle = false
    @Environment(\.dismiss) private var dismiss
    public var body: some View {
        Button(action: {
            dismiss.callAsFunction()
        }) {
            Image(systemName: closeStyle ? "xmark": "chevron.left")
                .roundedFont(weight: .semibold)
                .frame(width: 35, height: 35)
                .background(Color(uiColor: .systemBackground).opacity(0.5))
                .compositingGroup()
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .shadow(radius: 6)
        }
    }
    public func closingStyle() -> Self {
        return BackButtonView(closeStyle: true)
    }
}
