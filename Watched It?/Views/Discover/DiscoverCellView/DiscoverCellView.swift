//
//  DiscoverCellView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 11/01/2023.
//

import SwiftUI
import STools
import MediaUI

struct DiscoverCellView: View {
    let content: MediaPreview.Content
    var body: some View {
        VStack(spacing: 10) {
            Text(content.title)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundColor(.tint)
                .pin(to: .leading)
                .padding(.horizontal, 15)
            HStack {
                Text("Movies")
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                Spacer()
                NavigationLink(value: content.with(type: .movie)) {
                    Text("View All")
                        .fontWeight(.semibold)
                        .font(.caption)
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
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                Spacer()
                NavigationLink(value: content.with(type: .tv)) {
                    Text("View All")
                        .fontWeight(.semibold)
                        .font(.caption)
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
