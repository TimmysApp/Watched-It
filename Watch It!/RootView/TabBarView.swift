//
//  TabBarView.swift
//  Watch It!
//
//  Created by Joe Maghzal on 17/03/2023.
//

import SwiftUI
import STools

struct TabBarView: View {
    @Namespace var namespace
    @Binding var selectedPage: TabPage
    var body: some View {
        HStack {
            Spacer()
            ForEach(TabPage.allCases) { page in
                Button(action: {
                    selectedPage = page
                }) {
                    VStack {
                        Image(systemName: page.image)
                            .roundedFont(selectedPage == page ? .callout: .subheadline, weight: selectedPage == page ? .bold: .regular)
                        Text(page.title)
                            .roundedFont(selectedPage == page ? .footnote: .caption, weight: selectedPage == page ? .bold: .regular)
                    }.foregroundColor(selectedPage == page ? page.color: .gray)
                        .frame(maxHeight: .infinity)
                        .overlay(alignment: .top) {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 25, height: 4)
                                .matchedGeometryEffect(id: "tab", in: namespace)
                                .foregroundColor(page.color)
                                .hidden(selectedPage != page)
                        }.background {
                            Circle()
                                .fill(page.color.opacity(0.75))
                                .matchedGeometryEffect(id: "tabblur", in: namespace)
                                .padding(-15)
                                .padding(.vertical, 15)
                                .blur(radius: 30)
                                .hidden(selectedPage != page)
                        }.animation(.interactiveSpring().speed(0.5), value: selectedPage)
                }
                Spacer()
            }
        }.frame(height: 60)
        .padding(.bottom, 20)
        .background(Material.thin)
        .clipShape(ConfigurableRoundedRectangle(corners: [.topLeft, .topRight], radius: 20))
        .shadow(color: .darkShadow, radius: 6)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selectedPage: .constant(.home))
            .preferredColorScheme(.dark)
    }
}
