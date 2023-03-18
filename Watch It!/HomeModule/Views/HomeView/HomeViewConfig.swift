//
//  HomeViewConfig.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation
import NetworkUI
import WatchedItModels

@MainActor class HomeViewConfig: BaseViewConfig {
//MARK: - Properties
    @Published var sections = [MediaPreview.Content]()
    @Published var mediaType = MediaType.all
    @Published var isSearchLoading = false
    @Published var searchText = ""
    @Published var isSearching = false
//MARK: - Initializer
    override init() {
        super.init()
        isLoading = true
    }
//MARK: - Fetch
    override func task() async {
        await super.task()
        do {
            async let trendingMovies = Network.request(for: DiscoveryRoute.trending(page: 1, type: .movie, time: .day))
                .tryDecode(using: PageableResponse<MediaDetails>.self)
                .get()
                .results.map({$0.with(type: .movie).preview})
            async let trendingTvShows = Network.request(for: DiscoveryRoute.trending(page: 1, type: .tv, time: .day))
                .tryDecode(using: PageableResponse<MediaDetails>.self)
                .get()
                .results.map({$0.with(type: .tv).preview})
            async let popularMovies = Network.request(for: DiscoveryRoute.discover(page: 1, sorting: .popularityDescending, type: .movie))
                .tryDecode(using: PageableResponse<MediaDetails>.self)
                .get()
                .results.map({$0.with(type: .movie).preview})
            async let popularTvShows = Network.request(for: DiscoveryRoute.discover(page: 1, sorting: .popularityDescending, type: .tv))
                .tryDecode(using: PageableResponse<MediaDetails>.self)
                .get()
                .results.map({$0.with(type: .tv).preview})
            async let upcomingMovies = Network.request(for: MovieRoute.upcoming)
                .tryDecode(using: PageableResponse<MediaDetails>.self)
                .get()
                .results.map({$0.with(type: .movie).preview})
            self.sections = try await [MediaPreview.Content.trending(movies: trendingMovies, shows: trendingTvShows), .popular(movies: popularMovies, shows: popularTvShows), .upcoming(movies: upcomingMovies, shows: [])]
            isLoading = false
        }catch {
            isLoading = false
            self.error = error
            print(error)
        }
    }
}
