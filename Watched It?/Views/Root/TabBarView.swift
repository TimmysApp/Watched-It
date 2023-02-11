//
//  TabBarView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 11/02/2023.
//

import SwiftUI

struct TabBarView: View {
    @Binding var selection: RootTab
    var body: some View {
        HStack {
            Spacer()
            ForEach(RootTab.allCases) { tab in
                Button(action: {
                    selection = tab
                }) {
                    VStack {
                        Image(systemName: tab.icon)
                            .font(.title2)
                        Text(tab.title)
                            .font(.caption)
                    }.foregroundColor(tab == selection ? .accentColor: .gray)
                }
                Spacer()
            }
        }.padding(.horizontal, 5)
        .padding(.vertical, 10)
        .background(Material.ultraThin)
        .clipShape(Capsule())
        .compositingGroup()
        .shadow(color: .darkShadow, radius: 6, y: 8)
        .padding(.horizontal, 40)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selection: .constant(.discover))
    }
}
