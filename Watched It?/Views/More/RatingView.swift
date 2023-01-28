//
//  RatingView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 15/01/2023.
//

import SwiftUI

struct RatingView: View {
    @State var rating = 0
    var media: MediaPreview.PreviewType
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(0..<10) { index in
                    Button(action: {
                        rating = index + 1
                    }) {
                        Image(systemName: rating >= (index + 1) ? "star.fill": "star")
                            .foregroundColor(.yellow)
                    }
                }
            }
        }.padding(5)
        .frame(height: 35)
        .background(Color.basic.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(color: .darkShadow, radius: 6)
    }
}
