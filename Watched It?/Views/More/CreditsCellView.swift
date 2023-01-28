//
//  CreditsCellView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 15/01/2023.
//

import SwiftUI
import MediaUI

struct CreditsCellView: View {
    var preview: CreditsPreview
    var body: some View {
        NavigationLink(value: preview.type) {
            VStack(spacing: 0) {
                NetworkImage(url: preview.url)
                    .isResizable()
                    .squaredImage()
                    .aspect(contentMode: .fill)
                    .frame(width: (screenWidth - 30)/2 - 14, height: 225)
                    .placeHolder {
                        Image(systemName: "person")
                            .foregroundColor(.white)
                            .font(.system(size: 100))
                            .frame(width: (screenWidth - 30)/2 - 14, height: 225)
                            .background(Color.gray.opacity(0.6))
                            .compositingGroup()
                    }.clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .shadow(color: .darkShadow, radius: 6, y: 8)
                Text(preview.name)
                    .foregroundColor(Color.inverseBasic)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .padding(.top, 5)
                Text(preview.job)
                    .foregroundColor(.gray)
                    .font(.caption)
                    .fontWeight(.medium)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
            }.padding(7)
            .frame(width: (screenWidth - 30)/2)
            .background(Color.basic.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: 17, style: .continuous))
            .shadow(color: .darkShadow, radius: 6, y: 8)
        }
    }
}
