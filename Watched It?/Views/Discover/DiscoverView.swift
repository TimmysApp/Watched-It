//
//  DiscoverView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 11/01/2023.
//

import SwiftUI
import STools
import NetworkUI

struct DiscoverView: View {
    @State var config = DiscoverViewConfig()
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Text("Watched It?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .shadow(color: Color.darkShadow, radius: 5)
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image(systemName: "bookmark.fill")
                            .font(.title2.weight(.semibold))
                            .shadow(color: Color.coloredShadow, radius: 5)
                    }
                }.padding(.horizontal, 15)
                .padding(.top, 10)
                .transition(.move(edge: .top))
                .hidden(config.isSearching)
                SearchBarView(isSearching: $config.isSearching, placeholder: "Search Movies, TV Shows & People", searchText: $config.searchText)
                    .padding(.horizontal, 15)
                    .padding(.top, 10)
                    .padding(.bottom, 11)
                    .hidden(!config.searchBarFixed)
                ScrollView {
                    SearchBarView(isSearching: $config.isSearching, placeholder: "Search Movies, TV Shows & People", withFocus: false, searchText: $config.searchText)
                        .padding(.horizontal, 15)
                        .padding(.top, 10)
                        .hidden(config.searchBarFixed)
                    VStack(spacing: 10) {
                        Text("Explore")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.tint)
                            .pin(to: .leading)
                            .padding(.horizontal, 15)
                        Button(action: {
                            
                        }) {
                            HStack {
                                Text("Explore even More!")
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.body.weight(.medium))
                                    .foregroundColor(.white)
                            }.padding(10)
                            .background(Color.button.opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .compositingGroup()
                            .shadow(color: Color.coloredShadow, radius: 4, x: 0, y: 0)
                            .padding(.horizontal, 25)
                        }
                        ForEach(config.content) { content in
                            DiscoverCellView(content: content)
                        }
                    }
                    Spacer()
                }.opacity(config.searchBarFixed ? 0: 1)
                .overlay {
                    SearchResultsView(searchText: config.searchText)
                        .hidden(!config.searchBarFixed)
                }
            }.background(Color.background.gradient)
            .bindNetwork(withPlaceholder: false)
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: MediaPreview.Content.self) { content in
                DiscoverDetailsView(content: content)
            }.navigationDestination(for: MediaPreview.PreviewType.self) { preview in
                switch preview {
                    case .movie(let id):
                        MovieView(id: id)
                    case .tvShow(let id):
                        TVShowView(id: id)
                    case .person(let id):
                        PersonView(id: id)
                }
            }
        }.task {
            await config.fetch()
        }.task(id: config.isSearching) {
            if config.isSearching {
                try? await Task.sleep(nanoseconds: 5_000_000_00)
                config.searchBarFixed = true
            }else {
                config.searchBarFixed = false
            }
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
