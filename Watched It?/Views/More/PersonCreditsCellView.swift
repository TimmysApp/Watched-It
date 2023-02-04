//
//  PersonCreditsCellView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 28/01/2023.
//

import SwiftUI
import MediaUI
import STools

struct PersonCreditsCellView: View {
    var preview: MediaPreview
    var body: some View {
        HStack {
            if let url = preview.url {
                NetworkImage(url: url)
                    .isResizable()
                    .frame(height: 50)
                    .placeHolder {
                        Color.clear
                    }.clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                    .shadow(color: .darkShadow, radius: 6, y: 8)
            }
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(preview.title)
                        .foregroundColor(.inverseBasic)
                        .fontWeight(.semibold)
                    if let subTitle = preview.subTitle, !subTitle.isEmpty {
                        Text(subTitle)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
                Image(systemName: preview.type.image)
                    .font(.caption.weight(.semibold))
                    .foregroundColor(.tint)
            }.padding(10)
                .frame(height: 50)
                .background(Color.basic.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                .shadow(color: .darkShadow, radius: 6, y: 8)
        }
    }
}
