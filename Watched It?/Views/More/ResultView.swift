//
//  OptionsView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 18/01/2023.
//

import SwiftUI
import STools
import NetworkUI

struct ResultView: View {
    @Environment(\.dismiss) var dismiss
    let isError: Bool
    let title: String
    let summary: String
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Image(systemName: isError ? "xmark.circle": "checkmark.circle")
                .font(.system(size: 90).weight(.light))
                .foregroundColor(isError ? .red: .green)
                .shadow(color: .darkShadow, radius: 6, y: 8)
                .center(.horizontal)
            Spacer()
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .hidden(title.isEmpty)
            Text(summary)
                .multilineTextAlignment(.center)
                .lineLimit(5)
                .font(.callout)
                .fontWeight(.light)
                .foregroundColor(.gray)
                .hidden(summary.isEmpty)
            HStack(spacing: 30) {
                Button(action: {
                    
                }) {
                    Label("Report", systemImage: "paperplane.fill")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .center(.horizontal)
                        .frame(height: 50)
                        .background(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }.hidden(!isError)
                Button(action: {
                    dismiss.callAsFunction()
                }) {
                    Text("Dismiss")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .center(.horizontal)
                        .frame(height: 50)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(Color.gray, lineWidth: 2)
                        }.clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .shadow(color: .darkShadow, radius: 6, y: 8)
                }
            }.padding(.top, 20)
        }.padding(.horizontal, 30)
        .padding(.bottom, 10)
        .background(Color.sheetBackground)
        .presentationDetents([.height(300)])
        .presentationDragIndicator(.visible)
    }
}

extension View {
    func bindNetwork(initialyLoading: Bool = true, withPlaceholder: Bool = true) -> some View {
        modifier(NetworkBindingViewModifier(isLoading: initialyLoading, withPlaceholder: withPlaceholder))
    }
}
