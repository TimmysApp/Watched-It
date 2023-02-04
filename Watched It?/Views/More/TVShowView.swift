//
//  TVShowView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 16/01/2023.
//

import SwiftUI
import NetworkUI
import MediaUI
import STools

struct TVShowView: View {
    @State var config: TVShowViewConfig
    init(id: Int) {
        _config = State(initialValue: TVShowViewConfig(id: id))
    }
    var body: some View {
        VStack(spacing: -20) {
            if let tvShow = config.tvShow {
                HeaderView(title: tvShow.name) {
                    Button(action: {
                        config.showingDetails.toggle()
                    }) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.white)
                            .font(.title3.weight(.semibold))
                    }
                }
                ScrollView {
                    VStack(spacing: 15) {
                        SlidingImageView(poster: tvShow.posterPath?.medium, backdrop: tvShow.backdropPath?.large, status: tvShow.status ?? "", tagline: tvShow.tagline) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Spoken Languages")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .pin(to: .leading)
                                Text(tvShow.spokenLanguages.map(\.name).joined(separator: ", "))
                                    .font(.caption)
                                    .fontWeight(.light)
                                if let lastEpisode = tvShow.lastEpisodeToAir {
                                    Text("Last Episode To Air")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .padding(.top, 5)
                                    Text(lastEpisode.name)
                                        .font(.caption)
                                        .fontWeight(.light)
                                }
                                Text("Number Of Episodes")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .padding(.top, 5)
                                Text("\(tvShow.numberOfEpisodes) Episodes")
                                    .font(.caption)
                                    .fontWeight(.light)
                                Text("Production Companies")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .padding(.top, 5)
                                Text(tvShow.productionCompanies.map(\.name).joined(separator: ", "))
                                    .font(.caption)
                                    .fontWeight(.light)
                            }
                        }
                        HStack {
                            Text(tvShow.ageRating)
                                .font(.caption2)
                                .fontWeight(.medium)
                                .padding(5)
                                .background(Color.tint.opacity(0.6))
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                .compositingGroup()
                                .shadow(color: .darkShadow, radius: 6)
                            Text("First Episode Aired on ")
                                .font(.caption)
                            + Text(tvShow.firstAirDate.formattedString)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.tint)
                            Spacer()
                        }
                        HStack(alignment: .top) {
                            Text(tvShow.genres.map({$0.name}).joined(separator: ", "))
                                .font(.callout)
                                .fontWeight(.medium)
                            if let duration = tvShow.duration {
                                Text(duration)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .padding(5)
                                    .background(Color.basic.opacity(0.6))
                                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                    .compositingGroup()
                                    .shadow(color: .darkShadow, radius: 6)
                            }
                            Spacer()
                        }.padding(.top, -10)
                        HStack(spacing: 10) {
                            RatingView(media: tvShow.preview)
                            NavigationLink(value: tvShow.id) {
                                HStack {
                                    Text("Reviews")
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.body.weight(.medium))
                                        .foregroundColor(.white)
                                }.padding(10)
                                    .frame(height: 35)
                                    .background(Color.button.opacity(0.5))
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .compositingGroup()
                                    .shadow(color: Color.coloredShadow, radius: 4, x: 0, y: 0)
                            }
                        }.frame(height: 35)
                        if let trailer = config.videos?.trailer {
                            YouTubeView(id: trailer.key)
                                .background(ProgressView())
                                .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
                                .padding(.horizontal, 20)
                                .alignment(edge: .top, spacing: 0) {
                                    Text("Trailer")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .pin(to: .leading)
                                }.pin(to: .leading)
                        }
                        if let overview = tvShow.overview, !overview.isEmpty {
                            Text(overview)
                                .font(.callout)
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                                .alignment(edge: .top, spacing: 0) {
                                    Text("Overview")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .pin(to: .leading)
                                }.pin(to: .leading)
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(config.recomendations) { item in
                                    MediaView(preview: item)
                                }
                            }.padding(10)
                                .background(Color.basic.opacity(0.5))
                                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                                .padding(.horizontal, 20)
                        }.padding(.horizontal, -20)
                            .alignment(edge: .top, spacing: 5) {
                                Text("Recommendations")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .pin(to: .leading)
                            }.hidden(config.recomendations.isEmpty)
                        if let credits = config.credits {
                            VStack(spacing: 10) {
                                ForEach(credits.cast.limit(to: 10)) { item in
                                    CreditsView(preview: item.preview)
                                }
                            }.alignment(edge: .top, spacing: 5) {
                                HStack {
                                    Text("Cast & Crew")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    NavigationLink(value: credits) {
                                        Text("View All")
                                            .fontWeight(.semibold)
                                            .font(.caption)
                                    }
                                }
                            }
                        }
                    }.padding(.top, 30)
                    .padding(.bottom, 50)
                    .padding(.horizontal, 20)
                }
            }
        }.bindNetwork()
        .background(Color.background.gradient)
        .toolbar(.hidden, for: .navigationBar)
        .sheet(isPresented: $config.showingDetails) {
            OptionsView(media: config.tvShow?.preview)
        }.navigationDestination(for: Credits.self) { credits in
            CreditsDetailsView(credits: credits)
        }.navigationDestination(for: Int.self) { id in
            ReviewsView(type: .tvShow(id: id))
        }.navigationDestination(for: CreditsPreview.PreviewType.self) { item in
            switch item {
                case .cast(let id):
                    PersonView(id: id)
                case .crew(let id):
                    PersonView(id: id)
            }
        }.task {
            await config.fetch()
        }
    }
}
