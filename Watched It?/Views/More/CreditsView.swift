//
//  CreditsView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 15/01/2023.
//

import SwiftUI
import MediaUI

struct CreditsView: View {
    let preview: CreditsPreview
    var body: some View {
        NavigationLink(value: preview.type) {
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
                        Text(preview.name)
                            .foregroundColor(.inverseBasic)
                            .fontWeight(.semibold)
                        Text(preview.job)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }.padding(10)
                .frame(height: 50)
                .background(Color.basic.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                .shadow(color: .darkShadow, radius: 6, y: 8)
            }
        }
    }
}
