//
//  PersonView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 21/01/2023.
//

import SwiftUI
import STools
import MediaUI

struct PersonView: View {
    @State var config: PersonViewConfig
    init(id: Int) {
        _config = State(initialValue: PersonViewConfig(id: id))
    }
    init(name: String) {
        _config = State(initialValue: PersonViewConfig(name: name))
    }
    var body: some View {
        VStack(spacing: -20) {
            if let person = config.person {
                HeaderView(title: person.name) {
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
                        HStack {
                            NetworkImage(url: person.profilePath?.medium)
                                .isResizable()
                                .frame(height: 225)
                                .with(status: person.knownForDepartment ?? "")
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                .shadow(color: .darkShadow, radius: 6, y: 8)
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Gender")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .pin(to: .leading)
                                Text(person.gender?.title ?? "Unknown")
                                    .font(.caption)
                                    .fontWeight(.light)
                                Text("Birthday")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .padding(.top, 5)
                                Text(person.birthday?.formattedString ?? "Unknown")
                                    .font(.caption)
                                    .fontWeight(.light)
                                Text("Place of Birth")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .padding(.top, 5)
                                Text(person.placeOfBirth ?? "Unknown")
                                    .font(.caption)
                                    .fontWeight(.light)
                                if let known = person.alsoKnownAs, !known.isEmpty {
                                    Text("Known as")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .padding(.top, 5)
                                    Text(known.limit(to: 6).joined(separator: ", "))
                                        .font(.caption)
                                        .fontWeight(.light)
                                }
                            }
                        }
                        if let biography = person.biography, !biography.isEmpty {
                            Text(biography)
                                .font(.callout)
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                                .pin(to: .leading)
                                .alignment(edge: .top, spacing: 0) {
                                    Text("Biography")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .pin(to: .leading)
                                }
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(config.knownFor) { item in
                                    MediaView(preview: item)
                                }
                            }.padding(10)
                                .background(Color.basic.opacity(0.5))
                                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                                .padding(.horizontal, 20)
                        }.padding(.horizontal, -20)
                        .alignment(edge: .top, spacing: 5) {
                            Text("Known For")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .pin(to: .leading)
                        }.hidden(config.knownFor.isEmpty)
                        if !config.credits.isEmpty {
                            VStack(spacing: 10) {
                                ForEach(config.credits) { item in
                                    PersonCreditsCellView(preview: item)
                                }
                            }.alignment(edge: .top, spacing: 5) {
                                HStack {
                                    Text("Movies & TV Shows")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    NavigationLink(value: config.credits) {
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
//        .sheet(isPresented: $config.showingDetails) {
//            OptionsView(url: config.movie?.backdropPath?.large ?? config.movie?.posterPath?.medium, title: config.movie?.title ?? "", tagline: config.movie?.tagline)
//        }
        .navigationDestination(for: Credits.self) { credits in
            CreditsDetailsView(credits: credits)
        }.task {
            await config.fetch()
        }
    }
}
