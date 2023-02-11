//
//  TVShowViewConfig.swift
//  Watched It?
//
//  Created by Joe Maghzal on 16/01/2023.
//

import Foundation
import NetworkUI

struct TVShowViewConfig {
//MARK: - Properties
    var id: Int
    var tvShow: TVShow?
    var videos: Videos?
    var recomendations = [MediaPreview]()
    var credits: Credits?
    var showingDetails = false
//MARK: - Functions
    @MainActor mutating func fetch() async {
        guard tvShow == nil else {return}
        NetworkData.shared.isLoading = true
        do {
            let tvShowID = id
            async let tvShowData = Network.request(for: TVShowRoute.details(id: tvShowID))
                .tryDecode(using: TVShow.self)
                .handling(.error)
                .get()
            async let recomendationsData = Network.request(for: TVShowRoute.recomendations(id: tvShowID))
                .tryDecode(using: PageableResponse<MediaDetails>.self)
                .handling(.error)
                .get()
                .results.map(\.preview)
            async let creditsData = Network.request(for: TVShowRoute.credits(id: tvShowID))
                .tryDecode(using: Credits.self)
                .handling(.error)
                .get()
            async let videosData = Network.request(for: TVShowRoute.videos(id: tvShowID))
                .tryDecode(using: Videos.self)
                .handling(.error)
                .get()
            tvShow = try await tvShowData
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
