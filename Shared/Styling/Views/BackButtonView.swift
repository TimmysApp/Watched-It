//
//  BackButtonView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 15/01/2023.
//

import SwiftUI
import NetworkUI

struct BackButtonView: View {
    private var closeStyle = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button(action: {
            NetworkData.shared.isLoading = false
            dismiss.callAsFunction()
        }) {
            Image(systemName: closeStyle ? "xmark": "chevron.left")
                .fontWeight(.semibold)
                .frame(width: 35, height: 35)
                .background(Color.basic.opacity(0.5))
                .compositingGroup()
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .shadow(color: .darkShadow, radius: 6)
        }
    }
    func closingStyle() -> Self {
        return BackButtonView(closeStyle: true)
    }
}
