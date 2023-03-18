//
//  SectionView.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import SwiftUI
import STools

struct SectionView: View {
    let content: MediaPreview.Content
    var body: some View {
        VStack(spacing: 10) {
            Text(content.title)
                .roundedFont(.title3, weight: .semibold)
                .foregroundColor(.accentColor)
                .pin(to: .leading)
                .padding(.horizontal, 15)
            HStack {
                Text("Movies")
                    .roundedFont(weight: .medium)
                    .foregroundColor(.gray)
                Spacer()
                NavigationLink(value: NavigationRouter.allContent(content.with(type: .movie))) {
                    Text("View All")
                        .roundedFont(.caption, weight: .semibold)
                }
            }.padding(10)
            .background(Color.basic)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding(.horizontal, 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(content.movies) { movie in
                        MediaView(preview: movie)
                    }
                }.padding(.horizontal, 20)
            }
            HStack {
                Text("TV Shows")
                    .roundedFont(weight: .medium)
                    .foregroundColor(.gray)
                Spacer()
                NavigationLink(value: NavigationRouter.allContent(content.with(type: .tv))) {
                    Text("View All")
                        .roundedFont(.caption, weight: .semibold)
                }
            }.padding(10)
            .background(Color.basic)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding(.horizontal, 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(content.tvShows) { tvShow in
                        MediaView(preview: tvShow)
                    }
                }.padding(.horizontal, 20)
            }
        }
    }
}
