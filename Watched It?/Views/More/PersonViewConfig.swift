//
//  PersonViewConfig.swift
//  Watched It?
//
//  Created by Joe Maghzal on 21/01/2023.
//

import Foundation
import NetworkUI

struct PersonViewConfig {
//MARK: - Properties
    var id: Int?
    var name: String?
    var person: Person?
    var movieCredits = [MediaPreview]()
    var tvShowCredits = [MediaPreview]()
    var showingDetails = false
    var credits: [MediaPreview] {
        let combined = movieCredits + tvShowCredits
        return combined.limit(to: 10)
    }
    var knownFor: [MediaPreview] {
        let combined = movieCredits + tvShowCredits
        return combined.sorted(by: {$0.popularity > $1.popularity}).limit(to: 10)
    }
//MARK: - Functions
    @MainActor mutating func fetch() async {
        let personID: Int!
        NetworkData.shared.isLoading = true
        do {
            if let name {
                personID = try await Network.request(for: SearchRoute.people(page: 1, searchText: name, adult: true))
                    .tryDecode(using: PageableResponse<PersonInfo>.self)
                    .handling(.error)
                    .get()
                    .results.first?.id
            }else {
                personID = id
            }
            async let personData = Network.request(for: PersonRoute.details(id: personID))
                .tryDecode(using: Person.self)
                .handling(.error)
                .get()
            async let movieCreditsData = Network.request(for: PersonRoute.movieCredits(id: personID))
                .tryDecode(using: PersonCredits<MovieInfo>.self)
                .handling(.error)
                .get()
            async let tvShowCreditsData = Network.request(for: PersonRoute.tvShowCredits(id: personID))
                .tryDecode(using: PersonCredits<TVShowInfo>.self)
                .handling(.error)
                .get()
            person = try await personData
            movieCredits = try await movieCreditsData.cast.map(\.preview)
            tvShowCredits = try await tvShowCreditsData.cast.map(\.preview)
            NetworkData.shared.isLoading = false
        }catch {
            NetworkData.shared.isLoading = false
            print(error)
        }
    }
}
