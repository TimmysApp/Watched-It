//
//  DiscoverDetailsViewConfig.swift
//  Watched It?
//
//  Created by Joe Maghzal on 14/01/2023.
//

import Foundation

struct DiscoverDetailsViewConfig {
//MARK: - Properties
    var content: MediaPreview.Content
    var data: [MediaPreview]
    var type: MediaType
//MARK: - Initializer
    init(content: MediaPreview.Content) {
        self.content = content
        self.data = content.movies.isEmpty ? content.tvShows: content.movies
        self.type = content.movies.isEmpty ? .tv: .movie
    }
}
