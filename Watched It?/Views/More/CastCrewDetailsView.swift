//
//  CreditsDetailsView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 15/01/2023.
//

import SwiftUI
import STools

struct CreditsDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @State var config: CreditsDetailsViewConfig
    let columns = [GridItem(spacing: 10), GridItem(spacing: 10)]
    init(credits: Credits) {
        _config = State(initialValue: CreditsDetailsViewConfig(credits: credits))
    }
    var body: some View {
        VStack(spacing: 10) {
            BackButtonView()
                .padding(.horizontal, 30)
                .pin(to: .leading)
            Text("Credits")
                .font(.largeTitle)
                .fontWeight(.bold)
                .shadow(color: Color.darkShadow, radius: 5)
                .pin(to: .leading)
                .padding(.horizontal, 15)
            HStack(spacing: 20) {
                Button(action: {
                    withAnimation {
                        config.isCast = true
                    }
                }) {
                    Text("Cast")
                        .fontWeight(.semibold)
                        .foregroundColor(config.isCast ? .white: nil)
                        .center(.horizontal)
                        .frame(height: 35)
                        .background(config.isCast ? .tint: Color.basic.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .compositingGroup()
                        .shadow(color: .darkShadow, radius: 6, y: 8)
                }
                Button(action: {
                    withAnimation {
                        config.isCast = false
                    }
                }) {
                    Text("Crew")
                        .fontWeight(.semibold)
                        .foregroundColor(config.isCast ? nil: .white)
                        .center(.horizontal)
                        .frame(height: 35)
                        .background(config.isCast ? Color.basic.opacity(0.5): .tint)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .compositingGroup()
                        .shadow(color: .darkShadow, radius: 6, y: 8)
                }
            }.padding(.horizontal, 20)
            TabView(selection: $config.isCast) {
                ForEach(CreditsPreview.PreviewType.allCases) { item in
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(config.data(item.isCast)) { item in
                                CreditsCellView(preview: item)
                                    .clipped()
                            }
                        }.padding(.horizontal, 10)
                    }.tag(item.isCast)
                }
            }.tabViewStyle(.page(indexDisplayMode: .never))
        }.background(Color.background.gradient)
        .toolbar(.hidden, for: .navigationBar)
        .navigationDestination(for: CreditsPreview.PreviewType.self) { item in
            switch item {
                case .cast(let id):
                    PersonView(id: id)
                case .crew(let id):
                    PersonView(id: id)
            }
        }
    }
}
