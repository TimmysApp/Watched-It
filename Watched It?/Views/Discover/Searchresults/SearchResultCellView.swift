//
//  SearchResultCellView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 28/01/2023.
//

import SwiftUI
import MediaUI
import STools

struct SearchResultCellView: View {
    var result: SearchResultsViewConfig.SearchData
    var body: some View {
        if let person = result.thirdValue {
            mediaView(title: person.name, image: person.profilePath?.medium, type: .person(id: person.id))
        }else if let movie = result.firstValue {
            mediaView(title: movie.title, image: movie.backdropPath?.large ?? movie.posterPath?.medium, type: .movie(id: movie.id))
        }else if let tvShow = result.secondValue {
            mediaView(title: tvShow.name, image: tvShow.backdropPath?.large ?? tvShow.posterPath?.medium, type: .tvShow(id: tvShow.id))
        }
    }
    @ViewBuilder func mediaView(title: String, image: URL?, type: MediaPreview.PreviewType) -> some View {
        ZStack {
            NavigationLink(value: type) {
                EmptyView()
            }
            HStack(alignment: .center, spacing: 10) {
                if let url = image {
                    NetworkImage(url: url)
                        .isResizable()
                        .frame(height: 50)
                        .placeHolder {
                            ProgressView()
                        }.clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                        .shadow(color: .darkShadow, radius: 6)
                }
                Text(title)
                    .foregroundColor(.inverseBasic)
                    .font(.callout)
                    .fontWeight(.medium)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                Spacer()
                Image(systemName: type.image)
                    .font(.body.weight(.semibold))
                    .foregroundColor(.tint)
            }.padding(7)
            .frame(height: 62)
            .background(Color.basic.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: .darkShadow.opacity(0.5), radius: 6, y: 6)
        }.frame(height: 62)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 7.5, leading: 20, bottom: 7.5, trailing: 20))
        .listRowSeparator(.hidden)
    }
}
