//
//  MovieView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 14/01/2023.
//

import SwiftUI
import NetworkUI
import MediaUI
import STools

struct MovieView: View {
    @State var config: MovieViewConfig
    init(id: Int) {
        _config = State(initialValue: MovieViewConfig(id: id))
    }
    var body: some View {
        VStack(spacing: -20) {
            if let movie = config.movie {
                HeaderView(title: movie.title) {
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
                        SlidingImageView(poster: movie.posterPath?.medium, backdrop: movie.backdropPath?.large, status: movie.status.rawValue, tagline: movie.tagline) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Spoken Languages")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .pin(to: .leading)
                                Text(movie.spokenLanguages.map(\.name).joined(separator: ", "))
                                    .font(.caption)
                                    .fontWeight(.light)
                                Text("Budget")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .padding(.top, 5)
                                Text("USD \(movie.budget)")
                                    .font(.caption)
                                    .fontWeight(.light)
                                Text("Revenue")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .padding(.top, 5)
                                Text("USD \(movie.revenue)")
                                    .font(.caption)
                                    .fontWeight(.light)
                                Text("Production Companies")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .padding(.top, 5)
                                Text(movie.productionCompanies.map(\.name).joined(separator: ", "))
                                    .font(.caption)
                                    .fontWeight(.light)
                            }
                        }
                        HStack {
                            Text(movie.ageRating)
                                .font(.caption2)
                                .fontWeight(.medium)
                                .padding(5)
                                .background(Color.tint.opacity(0.6))
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                .compositingGroup()
                                .shadow(color: .darkShadow, radius: 6)
                            Text("Released on ")
                                .font(.caption)
                            + Text(movie.releaseDate.formattedString)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.tint)
                            Spacer()
                        }
                        HStack {
                            Text(movie.genres.map({$0.name}).limit(to: 4).joined(separator: ", "))
                                .fontWeight(.medium)
                            if let duration = movie.duration {
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
                        }.padding(.top, -15)
                        HStack(spacing: 10) {
                            RatingView(media: movie.preview)
                            Button(action: {
                            }) {
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
//                        if let trailer = config.videos?.trailer {
//                            YouTubeView(id: trailer.key)
//                                .background(ProgressView())
//                                .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
//                                .padding(.horizontal, 20)
//                                .alignment(edge: .top, spacing: 0) {
//                                    Text("Trailer")
//                                        .font(.title2)
//                                        .fontWeight(.semibold)
//                                        .pin(to: .leading)
//                                }.pin(to: .leading)
//                        }
                        if let overview = movie.overview, !overview.isEmpty {
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
        .background(Color.background.gradient).toolbar(.hidden, for: .navigationBar)
        .sheet(isPresented: $config.showingDetails) {
            OptionsView(media: config.movie?.preview)
        }.navigationDestination(for: Credits.self) { credits in
            CreditsDetailsView(credits: credits)
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
