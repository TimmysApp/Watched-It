//
//  SearchResultsView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 28/01/2023.
//

import SwiftUI
import STools

struct SearchResultsView: View {
    @State var config = SearchResultsViewConfig()
    var searchText: String
    var body: some View {
        ZStack {
            Text("Search Movies, TV Shows & People")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.gray)
                .hidden(!config.searchResults.isEmpty)
            List {
                ForEach(config.searchResults) { result in
                    SearchResultCellView(result: result)
                }
                ProgressView()
                    .center(.horizontal)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 6, leading: 20, bottom: 6, trailing: 20))
                    .listRowSeparator(.hidden)
                    .task {
                        await config.fetch()
                    }.hidden(!config.isPaginatable)
            }.listStyle(.plain)
            .scrollContentBackground(.hidden)
            .hidden(config.searchResults.isEmpty)
        }.task(id: searchText, priority: .userInitiated) {
            await config.search(searchText)
        }
    }
}
