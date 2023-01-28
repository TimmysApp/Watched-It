//
//  DiscoverViewConfig.swift
//  Watched It?
//
//  Created by Joe Maghzal on 11/01/2023.
//

import Foundation
import NetworkUI

struct DiscoverViewConfig {
//MARK: - Properties
    var isLoading = true
    var searchBarFixed = false
    var content = [MediaPreview.Content]()
    var isSearching = false
    var searchText = ""
//MARK: - Functions
    @MainActor mutating func fetch() async {
        guard content.isEmpty else {return}
        NetworkData.shared.isLoading = true
        do {
            async let trendingMovies = Network.request(for: DiscoveryRoute.trending(page: 1, type: .movie, time: .day), model: PageableResponse<MediaDetails>.self, withLoader: false).results.map({$0.with(type: .movie).preview})
            async let trendingTvShows = Network.request(for: DiscoveryRoute.trending(page: 1, type: .tv, time: .day), model: PageableResponse<MediaDetails>.self, withLoader: false).results.map({$0.with(type: .tv).preview})
            async let popularMovies = Network.request(for: DiscoveryRoute.discover(page: 1, sorting: .popularityDescending, type: .movie), model: PageableResponse<MediaDetails>.self, withLoader: false).results.map({$0.with(type: .movie).preview})
            async let popularTvShows = Network.request(for: DiscoveryRoute.discover(page: 1, sorting: .popularityDescending, type: .tv), model: PageableResponse<MediaDetails>.self, withLoader: false).results.map({$0.with(type: .tv).preview})
            async let upcomingMovies = Network.request(for: MovieRoute.upcoming, model: PageableResponse<MediaDetails>.self, withLoader: false).results.map({$0.with(type: .movie).preview})
            try await content.append(.trending(movies: trendingMovies, shows: trendingTvShows))
            try await content.append(.popular(movies: popularMovies, shows: popularTvShows))
            try await content.append(.upcoming(movies: upcomingMovies, shows: []))
            NetworkData.shared.isLoading = false
        }catch {
            NetworkData.shared.isLoading = false
            print(error)
        }
    }
}
