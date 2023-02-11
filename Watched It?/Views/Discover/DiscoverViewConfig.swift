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
    mutating func fetch() async {
        guard content.isEmpty else {return}
        await MainActor.run {
            NetworkData.shared.isLoading = true
        }
        do {
            async let trendingMovies = Network.request(for: DiscoveryRoute.trending(page: 1, type: .movie, time: .day))
                .tryDecode(using: PageableResponse<MediaDetails>.self)
                .handling(.error)
                .get()
                .results.map({$0.with(type: .movie).preview})
            async let trendingTvShows = Network.request(for: DiscoveryRoute.trending(page: 1, type: .tv, time: .day))
                .tryDecode(using: PageableResponse<MediaDetails>.self)
                .handling(.error)
                .get()
                .results.map({$0.with(type: .tv).preview})
            async let popularMovies = Network.request(for: DiscoveryRoute.discover(page: 1, sorting: .popularityDescending, type: .movie))
                .tryDecode(using: PageableResponse<MediaDetails>.self)
                .handling(.error)
                .get()
                .results.map({$0.with(type: .movie).preview})
            async let popularTvShows = Network.request(for: DiscoveryRoute.discover(page: 1, sorting: .popularityDescending, type: .tv))
                .tryDecode(using: PageableResponse<MediaDetails>.self)
                .handling(.error)
                .get()
                .results.map({$0.with(type: .tv).preview})
            async let upcomingMovies = Network.request(for: MovieRoute.upcoming)
                .tryDecode(using: PageableResponse<MediaDetails>.self)
                .handling(.error)
                .get()
                .results.map({$0.with(type: .movie).preview})
            let contents = try await [MediaPreview.Content.trending(movies: trendingMovies, shows: trendingTvShows), .popular(movies: popularMovies, shows: popularTvShows), .upcoming(movies: upcomingMovies, shows: [])]
            await update(contents: contents)
        }catch {
            await MainActor.run {
                NetworkData.shared.isLoading = false
            }
            print(error)
        }
    }
    @MainActor mutating func update(contents: [MediaPreview.Content]) async {
        content.append(contentsOf: contents)
        NetworkData.shared.isLoading = false
    }
}
