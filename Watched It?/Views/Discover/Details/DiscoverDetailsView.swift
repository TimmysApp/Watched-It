//
//  DiscoverDetailsView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 14/01/2023.
//

import SwiftUI
import STools

struct DiscoverDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @State var config: DiscoverDetailsViewConfig
    let columns = [GridItem(spacing: 20), GridItem(spacing: 20)]
    init(content: MediaPreview.Content) {
        _config = State(initialValue: DiscoverDetailsViewConfig(content: content))
    }
    var body: some View {
        VStack(spacing: 0) {
            BackButtonView()
                .padding(.horizontal, 30)
                .pin(to: .leading)
            Text("\(config.content.title) \(config.type.title)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .shadow(color: Color.darkShadow, radius: 5)
                .pin(to: .leading)
                .padding(.horizontal, 15)
                .padding(.top, 10)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(config.data) { item in
                        MediaView(preview: item, isDetail: true)
                            .clipped()
                    }
                }.padding(.horizontal, 20)
            }
            Spacer()
        }.background(Color.background.gradient)
        .toolbar(.hidden, for: .navigationBar)
    }
}
