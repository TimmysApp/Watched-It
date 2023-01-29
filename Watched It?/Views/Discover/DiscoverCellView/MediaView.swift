//
//  MediaView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 11/01/2023.
//

import SwiftUI
import MediaUI

struct MediaView: View {
    var preview: MediaPreview
    var isDetail = false
    var body: some View {
        NavigationLink(value: preview.type) {
            VStack(spacing: 10) {
                NetworkImage(url: preview.url)
                    .isResizable()
                    .squaredImage()
                    .frame(width: isDetail ? (screenWidth - 60)/2: 150, height: isDetail ? nil: 225)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .shadow(color: .darkShadow, radius: 6, y: 8)
                Text(preview.title)
                    .foregroundColor(Color.inverseBasic)
                    .font(.caption)
                    .fontWeight(.bold)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                if let subtitle = preview.subTitle {
                    Text(subtitle)
                        .foregroundColor(Color.gray)
                        .font(.caption2)
                        .fontWeight(.medium)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .padding(.top, -10)
                }
                Spacer()
                    .padding(.vertical, -10)
            }.frame(width: isDetail ? (screenWidth - 60)/2: 150)
        }
    }
}
