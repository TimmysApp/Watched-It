//
//  SearchResultsViewConfig.swift
//  Watched It?
//
//  Created by Joe Maghzal on 28/01/2023.
//

import Foundation
import NetworkUI

struct SearchResultsViewConfig {
//MARK: - Properties
    var searchResults = [SearchData]()
    var currentPage = 0
    var totalPages = 0
    var type: SearchType?
    var adult = true
    var searchText = ""
    var currentTask: Task<PageableResponse<SearchData>, Error>?
    var isPaginatable: Bool {
        return totalPages > currentPage
    }
//MARK: - Functions
    @MainActor mutating func search(_ text: String) async {
        currentTask?.cancel()
        searchText = text
        currentPage = 0
        totalPages = 0
        guard !searchText.isEmpty else {
            searchResults.removeAll()
            return
        }
        await fetch()
    }
    @MainActor mutating func fetch() async {
        guard (currentPage < totalPages && totalPages > 0) || totalPages == 0 else {return}
        currentPage = currentPage + 1
        do {
            let route = type?.route(for: searchText, adult: adult, page: currentPage) ?? SearchRoute.multi(page: currentPage, searchText: searchText, adult: adult)
            if let route = type?.route(for: searchText, adult: adult, page: currentPage) {
//                currentTask = try await Network.request(for: route)
//                    .tryDecode(using: PageableResponse<SearchData>.self)
//                    .handling(.error)
//                    .task()
            }else {
                currentTask = try await Network.request(for: SearchRoute.multi(page: currentPage, searchText: searchText, adult: adult))
                    .tryDecode(using: PageableResponse<SearchData>.self)
                    .handling(.error)//.none
                    .task()
            }
            if let data = try await currentTask?.value {
                if currentPage == 1 {
                    searchResults = data.results
                }else {
                    searchResults.append(contentsOf: data.results)
                }
                totalPages = data.totalPages
            }
        }catch {
            print(error)
        }
    }
//MARK: - Types
    typealias SearchData = Superposition3<MovieInfo, TVShowInfo, PersonInfo>
    enum SearchType {
        case people, tvShows, movies
        func route(for text: String, adult: Bool, page: Int) -> EndPoint {
            switch self {
                case .people:
                    return SearchRoute.people(page: page, searchText: text, adult: adult)
                case .tvShows:
                    return SearchRoute.tvShows(page: page, searchText: text, adult: adult)
                case .movies:
                    return SearchRoute.movies(page: page, searchText: text, adult: adult)
            }
        }
    }

}
