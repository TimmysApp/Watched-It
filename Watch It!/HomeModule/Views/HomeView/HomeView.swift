//
//  HomeView.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import SwiftUI

struct HomeView: BaseView {
    @StateObject var config = HomeViewConfig()
    var content: some View {
        NavigationStackView {
            VStack(spacing: 0) {
                topView
                ScrollView {
                    VStack(spacing: 10) {
                        filtersView
                        ForEach(config.sections) { content in
                            SectionView(content: content)
                        }
                    }
                }.refreshable {
                    await config.task()
                }
            }.edgesIgnoringSafeArea(.top)
            .toolbar(.hidden, for: .navigationBar)
            .background(Color.background.gradient)
        }
    }
    var topView: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Watched It?")
                    .roundedFont(.largeTitle, weight: .bold)
                    .shadow(color: .darkShadow, radius: 5)
                Spacer()
                Button(action: {
                    config.route(to: .authentication)
                }) {
                    Image(systemName: "person")
                        .roundedFont(weight: .bold)
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .background(Color.gray)
                        .clipShape(Circle())
                }
            }.padding(.top, 110)
            .transition(.move(edge: .top))
            .hidden(config.isSearching)
            SearchBarView(searchText: $config.searchText, isSearching: $config.isSearching, isLoading: config.isSearchLoading, placeholder: "Search Movies, TV Shows & People")
                .roundedFont(weight: .medium)
                .shadow(color: .darkShadow, radius: 6, y: 3)
                .padding(.top, config.isSearching ? 110: 10)
            Color.clear
                .frame(height: 20)
        }.animation(.spring(), value: config.isSearching)
        .padding(.horizontal, 20)
        .background {
            Image("TopMask")
                .resizable()
                .blur(radius: 30)
                .overlay(Color.basic.opacity(0.7))
        }.clipShape(ConfigurableRoundedRectangle(corners: [.bottomLeft, .bottomRight], radius: 40))
        .shadow(color: .darkShadow, radius: 6, y: 8)
        .padding(.top, -50)
        .zIndex(100)
    }
    var filtersView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Button(action: {
                    
                }) {
                    Label("Filter", systemImage: "slider.horizontal.2.square.on.square")
                        .roundedFont(.callout, weight: .semibold)
                        .foregroundColor(.white)
                        .frame(width: 90, height: 30)
                        .background(Color.greeny)
                        .clipShape(Capsule())
                }
                Divider()
                ForEach(MediaType.allCases) { type in
                    Button(action: {
                        withAnimation(.easeIn) {
                            config.mediaType = type
                        }
                    }) {
                        Text(type.title)
                            .roundedFont(.callout, weight: .semibold)
                            .foregroundColor(.white)
                            .frame(width: 90, height: 30)
                            .background(Color.greeny)
                            .opacity(type == config.mediaType ? 1: 0.3)
                            .clipShape(Capsule())
                    }
                }
            }.padding(.horizontal, 20)
        }.padding(.vertical)
    }
}
