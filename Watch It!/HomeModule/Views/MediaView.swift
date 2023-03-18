//
//  MediaView.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import SwiftUI
import STools

struct MediaView: View {
    var preview: MediaPreview
    var isDetail = false
    var body: some View {
        NavigationLink(value: NavigationRouter.media(preview.type)) {
            VStack(spacing: 10) {
                let width = isDetail ? (screenWidth - 60)/2: 150
                RemoteImage(url: preview.url)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: width * 1.5)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .shadow(color: .darkShadow, radius: 6, y: 8)
                Text(preview.title)
                    .roundedFont(.caption, weight: .bold)
                    .foregroundColor(Color.inverseBasic)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                if let subtitle = preview.subTitle {
                    Text(subtitle)
                        .roundedFont(.caption2, weight: .medium)
                        .foregroundColor(Color.gray)
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
