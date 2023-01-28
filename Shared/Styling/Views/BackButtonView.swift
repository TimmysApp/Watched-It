//
//  BackButtonView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 15/01/2023.
//

import SwiftUI
import NetworkUI

struct BackButtonView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button(action: {
            NetworkData.shared.isLoading = false
            dismiss.callAsFunction()
        }) {
            Image(systemName: "chevron.left")
                .font(.title3.weight(.semibold))
                .frame(width: 35, height: 35)
                .background(Color.basic.opacity(0.5))
                .compositingGroup()
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .shadow(color: .darkShadow, radius: 6)
        }
    }
}
