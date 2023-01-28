//
//  CollapsableViewModifier.swift
//  Watched It?
//
//  Created by Joe Maghzal on 21/01/2023.
//

import SwiftUI

struct CollapsableViewModifier: ViewModifier {
    @State private var isExpanded: Bool = false
    @State private var isTruncated: Bool = false
    var lineLimit: Int
    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content
                .lineLimit(isExpanded ? nil: lineLimit)
                .background {
                    content
                        .lineLimit(lineLimit)
                        .background {
                            GeometryReader { displayReader in
                                ZStack {
                                    content
                                        .background {
                                            GeometryReader { reader in
                                                Color.clear
                                                    .onAppear {
                                                        isTruncated = reader.size.height > displayReader.size.height
                                                    }
                                            }
                                        }
                                }.frame(height: .greatestFiniteMagnitude)
                            }
                        }
                }
            Button(action: {
                withAnimation(.easeInOut) {
                    isExpanded.toggle()
                }
            }) {
                Text(isExpanded ? "Show Less": "Show More")
                    .font(.caption)
                    .fontWeight(.medium)
            }
        }
    }
}

extension Text {
    func collapsable(_ lineLimit: Int) -> some View {
        modifier(CollapsableViewModifier(lineLimit: lineLimit))
    }
}
