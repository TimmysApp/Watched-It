//
//  SlidingImageView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 15/01/2023.
//

import SwiftUI
import MediaUI

struct SlidingImageView<Content: View>: View {
    @State var height = CGFloat.zero
    @State var isShowingDetails = false
    var poster: URL?
    var backdrop: URL?
    var status: String
    var tagline: String?
    var content: Content
    init(poster: URL? = nil, backdrop: URL? = nil, status: String, tagline: String? = nil, @ViewBuilder content: () -> Content) {
        self.poster = poster
        self.backdrop = backdrop
        self.status = status
        self.tagline = tagline
        self.content = content()
        self._isShowingDetails = State(initialValue: backdrop == nil)
        self._height = State(initialValue: backdrop == nil ? 225: .zero)
    }
    var body: some View {
        Group {
            NetworkImage(url: backdrop)
                .isResizable()
                .frame(width: screenWidth - 40)
                .overlay {
                    LinearGradient(stops: [.init(color: .clear, location: 0.05), .init(color: .black.opacity(0.8), location: 0.95)], startPoint: .top, endPoint: .bottom)
                        .overlay(alignment: .bottom) {
                            VStack(spacing: 0) {
                                Text("Swipe \(isShowingDetails ? "right": "left") to see more!")
                                    .font(.caption2)
                                    .fontWeight(.light)
                                    .foregroundColor(.white)
                                Text(tagline ?? "")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }.opacity(0.8)
                            .padding(.bottom, 5)
                            .transition(.slide)
                        }.transition(.slide)
                        .hidden(isShowingDetails || height < 50)
                }.with(status: height > 50 ? status: "")
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: .darkShadow, radius: 6, y: 8)
                .onSwipe(.leading) {
                    guard poster != nil else {return}
                    withAnimation(.easeInOut) {
                        isShowingDetails = true
                    }
                }.onChange(of: .height) { newValue in
                    height = newValue
                }.transition(.slide)
                .hidden(isShowingDetails)
            HStack {
                NetworkImage(url: poster)
                    .isResizable()
                    .frame(height: height)
                    .with(status: height > 50 ? status: "")
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: .darkShadow, radius: 6, y: 8)
                    .onSwipe(.trailing) {
                        guard backdrop != nil else {return}
                        withAnimation(.easeInOut) {
                            isShowingDetails = false
                        }
                    }
                content
            }.transition(.slide)
            .hidden(!isShowingDetails)
        }.animation(.easeInOut)
    }
}
