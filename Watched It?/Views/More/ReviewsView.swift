//
//  ReviewsView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 21/01/2023.
//

import SwiftUI

struct ReviewsView: View {
    @State var config: ReviewsViewConfig
    init(type: MediaPreview.PreviewType) {
        config = ReviewsViewConfig(type: type)
    }
    var body: some View {
        List {
            ForEach(config.reviews) { review in
                ReviewCellView(review: review)
                    .task {
                        await config.paginate(at: review)
                    }
            }
        }.listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color.background.gradient)
        .task {
            await config.load()
        }
    }
}
