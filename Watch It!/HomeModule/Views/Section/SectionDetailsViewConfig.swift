//
//  SectionDetailsViewConfig.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation
import NetworkUI

@MainActor class SectionDetailsViewConfig: BaseViewConfig {
//MARK: - Properties
    @Published var content: MediaPreview.Content
    @Published var data: [MediaPreview]
    @Published var type: MediaType
    var currentPage = 1
    var totalPages = 2
    var currentTask: Task<PageableResponse<MediaDetails>, Error>?
    var isPaginatable: Bool {
        return totalPages > currentPage
    }
    var shouldLoad = false {
        willSet {
            guard !newValue && shouldLoad else {return}
            Task {
                await fetch()
            }
        }
    }
//MARK: - Initializer
    init(content: MediaPreview.Content) {
        self.content = content
        self.data = content.movies.isEmpty ? content.tvShows: content.movies
        self.type = content.movies.isEmpty ? .tv: .movie
    }
//MARK: - Functions
    func fetch(reloading: Bool = false) async {
        guard (currentPage < totalPages && totalPages > 0) || totalPages == 0 || reloading else {return}
        currentPage = reloading ? 1: currentPage + 1
        if reloading {
            currentTask?.cancel()
        }else {
            guard !shouldLoad else {return}
            shouldLoad = currentTask?.isCancelled ?? false
        }
        do {
            currentTask = try await Network.request(for: content.route(page: currentPage))
                .tryDecode(using: PageableResponse<MediaDetails>.self)
                .task()
            guard let networkData = try await currentTask?.value else {return}
            if currentPage == 1 {
                data = networkData.results.map(\.preview)
            }else {
                data.append(contentsOf: networkData.results.map(\.preview))
            }
            totalPages = networkData.totalPages
            shouldLoad = false
        }catch {
            print(error)
        }
    }
}
