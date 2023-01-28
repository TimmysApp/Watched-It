//
//  ReviewsCellView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 21/01/2023.
//

import SwiftUI

struct ReviewCellView: View {
    let review: Review
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .trailing, spacing: 0) {
                    HStack {
                        HStack {
                            Spacer()
                            Text(review.authorDetails.username)
                                .fontWeight(.semibold)
                            Spacer()
                        }.padding(10)
                        .frame(height: 35)
                        .background(Color.accentColor.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                        .padding(.bottom, 5)
                        RatingView(rating: review.authorDetails.rating ?? 0, media: .movie(id: 0))
                            .clipShape(ConfigurableRoundedRectangle(corners: [UIRectCorner.topLeft, .topRight], radius: 9))
                    }
                    HStack {
                        Spacer()
                        Text("written at \(review.createdAt.formattedString)")
                        Spacer()
                    }.padding(10)
                    .frame(height: 35)
                    .background(Color.accentColor.opacity(0.3))
                    .clipShape(ConfigurableRoundedRectangle(corners: [UIRectCorner.bottomLeft, .bottomRight, .topLeft], radius: 9))
                }.shadow(color: .darkShadow, radius: 6, y: 8)
            }
            HStack {
                Spacer()
                Text(review.content)
                    .collapsable(4)
                Spacer()
            }.padding(10)
            .background(Color.accentColor.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .shadow(color: .darkShadow, radius: 6, y: 8)
            .padding(.top, 10)
        }.padding(.horizontal)
            .listRowBackground(Color.clear)
            .listRowInsets(nil)
    }
}
