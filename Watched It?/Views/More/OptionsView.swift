//
//  OptionsView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 18/01/2023.
//

import SwiftUI
import MediaUI
import DataStruct

struct OptionsView: View {
    @Environment(\.dismiss) var dismiss
    @State var config: OptionsViewConfig
    init(media: MediaPreview?) {
        _config = State(initialValue: OptionsViewConfig(media: media))
    }
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .center) {
                NetworkImage(url: config.media?.url)
                    .isResizable()
                    .frame(height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .shadow(color: .darkShadow, radius: 6, y: 8)
                VStack(alignment: .leading, spacing: 0) {
                    Text(config.media?.title ?? "")
                        .font(.callout)
                        .fontWeight(.semibold)
                    Text(config.media?.subTitle ?? "")
                        .foregroundColor(.gray)
                        .font(.caption2)
                        .fontWeight(.medium)
                        .hidden(config.media?.subTitle?.isEmpty == true)
                }
                Spacer()
                Button(action: {
                    dismiss.callAsFunction()
                }) {
                    Text("Close")
                        .font(.callout)
                        .fontWeight(.semibold)
                }
            }.padding(.horizontal, 10)
            .padding(.top, 10)
            RoundedRectangle(cornerRadius: 1, style: .continuous)
                .fill(Color.gray)
                .frame(height: 1)
            VStack(spacing: 10) {
                OptionView(image: config.options?.watchList ?? false ? "bookmark.fill": "bookmark", title: config.options?.watchList ?? false ? "Remove from Watchlist": "Add to Watchlist", color: .tint) {
                    config.toggleWatchlist()
                }
                OptionView(image: config.options?.isFavorite ?? false ? "heart.fill": "heart", title: config.options?.isFavorite ?? false ? "Remove from Favorites": "Add to Favorites", color: .pink) {
                    config.toggleFavorite()
                }
                OptionView(image: "square.and.arrow.up.fill", title: "Share", color: .inverseBasic) {
                    
                }
            }.padding(.horizontal, 20)
            .padding(.top, 10)
            Spacer()
        }.padding(.top, 10)
        .background(Color.sheetBackground)
        .presentationDragIndicator(.visible)
        .presentationDetents([.height(250)])
        .task {
            config.fetch()
        }
    }
}

struct OptionView: View {
    let image: String
    let title: String
    var subtitle = ""
    var color = Color.white
    var action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack(spacing: 10) {
                Image(systemName: image)
                    .frame(width: 40, height: 40)
                    .background(Color.basic.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                (Text(title + " ")
                    .font(.callout)
                    .fontWeight(.semibold) +
                 Text(subtitle )
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                ).padding(10)
                .pin(to: .leading)
                .frame(height: 40)
                .background(Color.basic.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }.shadow(color: .darkShadow, radius: 6)
        }.foregroundColor(color)
        .frame(height: 40)
    }
}
