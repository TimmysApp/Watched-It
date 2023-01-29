//
//  RatingView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 15/01/2023.
//

import SwiftUI
import DataStruct

struct RatingView: View {
    @State var config: RatingViewConfig
    init(media: MediaPreview) {
        _config = State(initialValue: RatingViewConfig(media: media))
    }
    init(rating: Int) {
        _config = State(initialValue: RatingViewConfig(rating: rating))
    }
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(0..<10) { index in
                    Button(action: {
                        config.rate(index + 1)
                    }) {
                        Image(systemName: config.rating >= (index + 1) ? "star.fill": "star")
                            .foregroundColor(.yellow)
                    }.disabled(config.media == nil)
                }
            }
        }.padding(5)
        .frame(height: 35)
        .background(Color.basic.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(color: .darkShadow, radius: 6)
        .task {
            config.fetch()
        }
    }
}
