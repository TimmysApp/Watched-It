//
//  MovieViewConfig.swift
//  Watched It?
//
//  Created by Joe Maghzal on 15/01/2023.
//

import Foundation
import NetworkUI

struct MovieViewConfig {
//MARK: - Properties
    var id: Int
    var movie: Movie?
    var videos: Videos?
    var recomendations = [MediaPreview]()
    var credits: Credits?
    var showingDetails = false
//MARK: - Functions
    @MainActor mutating func fetch() async {
        guard movie == nil else {return}
        NetworkData.shared.isLoading = true
        do {
            let movieID = id
            async let movieData = Network.request(for: MovieRoute.details(id: movieID), model: Movie.self, withLoader: false)
            async let recomendationsData = Network.request(for: MovieRoute.recomendations(id: movieID), model: PageableResponse<MediaDetails>.self, withLoader: false).results.map(\.preview)
            async let creditsData = Network.request(for: MovieRoute.credits(id: movieID), model: Credits.self, withLoader: false)
            async let videosData = Network.request(for: MovieRoute.videos(id: movieID), model: Videos.self, withLoader: false)
            movie = try await movieData
            recomendations = try await recomendationsData
            credits = try await creditsData
            videos = try await videosData
            NetworkData.shared.isLoading = false
        }catch {
            print(error)
            NetworkData.shared.isLoading = false
        }
    }
}
