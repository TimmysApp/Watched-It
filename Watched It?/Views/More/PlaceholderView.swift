//
//  PlaceholderView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 15/01/2023.
//

import SwiftUI
import STools
import NetworkUI

struct PlaceholderView: View {
    @Environment(\.dismiss) var dismiss
    var isLoading = true
    var body: some View {
        VStack {
            HeaderView(title: "")
            ScrollView {
                VStack(spacing: 10) {
                    Color.gray
                        .frame(width: screenWidth - 40, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    Text("In quantum mechanics, time is understood as an external (‘classical’) concept. So it is assumed, as in classical physics, to exist as a controller of all motion — either as absolute time or in the form of proper times defined by a classical spacetime metric. In the latter case it is applicable to local quantum systems along their world lines. According to this assumption, time can be read from appropriate classical or quasi-classical ‘clocks’.")
                        .padding(.horizontal, 20)
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            ForEach(0..<3) { _ in
                                VStack(spacing: 10) {
                                    Image("Mask")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150, height: 225)
                                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                        .shadow(color: .darkShadow, radius: 6, y: 8)
                                    Text("Quantum Time Theory")
                                        .foregroundColor(Color.inverseBasic)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(3)
                                    Spacer()
                                        .padding(.vertical, -10)
                                }.frame(width: 150)
                            }
                        }.padding(10)
                            .background(Color.basic.opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                            .padding(.horizontal, 20)
                    }.padding(.horizontal, -20)
                    Spacer()
                }
            }.redacted(reason: .placeholder)
            .showLoading(true)
        }
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView()
    }
}
