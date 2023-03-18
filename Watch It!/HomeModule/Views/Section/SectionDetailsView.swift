//
//  SectionDetailsView.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import SwiftUI
import STools

struct SectionDetailsView: BaseView {
    @StateObject var config: SectionDetailsViewConfig
    let columns = [GridItem(spacing: 20), GridItem(spacing: 20)]
    init(content: MediaPreview.Content) {
        _config = StateObject(wrappedValue: SectionDetailsViewConfig(content: content))
    }
    var content: some View {
        VStack(spacing: 0) {
            BackButtonView()
                .padding(.horizontal, 30)
                .pin(to: .leading)
            Text("\(config.content.title) \(config.type.title)")
                .roundedFont(.largeTitle, weight: .bold)
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
                    ProgressView()
                        .controlSize(.large)
                        .center(.horizontal)
                        .task(priority: .background) {
                            await config.fetch()
                        }.hidden(!config.isPaginatable)
                }.padding(.horizontal, 20)
            }.refreshable {
                await config.fetch(reloading: true)
            }
        }.background(Color.background.gradient)
        .toolbar(.hidden, for: .navigationBar)
    }
}
