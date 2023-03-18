//
//  HeaderView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 15/01/2023.
//

import SwiftUI

public struct HeaderView<Content: View>: View {
    private let title: String
    private var content: Content
    public init(title: String, @ViewBuilder content: () -> Content = {Color.clear}) {
        self.title = title
        self.content = content()
    }
    public var body: some View {
        Color.basic
            .opacity(0.7)
            .background {
                Image("Mask")
                    .resizable()
                    .blur(radius: 15)
            }.overlay(alignment: .top) {
                HStack {
                    BackButtonView()
                    Spacer()
                    content
                }.overlay {
                    Text(title)
                        .roundedFont(weight: .semibold)
                        .foregroundColor(.white)
                        .opacity(0.8)
                        .compositingGroup()
                        .shadow(radius: 5)
                }.padding(10)
            }.frame(height: 55)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .padding(.horizontal, 20)
            .zIndex(1)
    }
}
