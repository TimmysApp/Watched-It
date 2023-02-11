//
//  ReviewsViewConfig.swift
//  Watched It?
//
//  Created by Joe Maghzal on 21/01/2023.
//

import Foundation
import NetworkUI

struct ReviewsViewConfig {
//MARK: - Properties
    var reviews = [Review]()
    var currentPage = 1
    var totalPages = 2
    var type: MediaPreview.PreviewType
//MARK: - Functions
    @MainActor mutating func paginate(at item: Review) async {
        guard let index = reviews.firstIndex(of: item), index == reviews.count - 2 else {return}
        await fetch()
    }
    @MainActor mutating func fetch() async {
        guard currentPage < totalPages else {return}
        do {
            var data: PageableResponse<Review>!
            if type.type == .movie {
                data = try await Network.request(for: MovieRoute.reviews(id: type.mediaId, page: currentPage))
                    .tryDecode(using: PageableResponse<Review>.self)
                    .get()
            }else {
                data = try await Network.request(for: TVShowRoute.reviews(id: type.mediaId))
                    .tryDecode(using: PageableResponse<Review>.self)
                    .get()
            }
            if currentPage == 1 {
                reviews = data.results
            }else {
                reviews.append(contentsOf: data.results)
            }
            currentPage = data.page + 1
            totalPages = data.totalPages
        }catch {
            print(error)
        }
    }
    @MainActor mutating func load() async {
        guard reviews.isEmpty else {return}
        await fetch()
    }
}
