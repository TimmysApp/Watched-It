//
//  RecentsCellView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 10/01/2023.
//

import SwiftUI
import MediaUI

struct RecentsCellView: View {
    @Binding var selectedItems: [IdentifiedItem]
    var editMode: Bool
    var item: IdentifiedItem
    var isSelected: Bool {
        return selectedItems.contains(item)
    }
    var body: some View {
        Button(action: {
            if editMode {
                withAnimation(.easeInOut) {
                    isSelected ? selectedItems.removeAll(where: {$0.id == item.id}): selectedItems.append(item)
                }
            }
        }) {
            HStack {
                Image(systemName: isSelected ? "checkmark.circle.fill": "circle")
                    .foregroundColor(.tint)
                    .font(.title3.weight(.medium))
                    .hidden(!editMode)
                HStack(alignment: .center) {
                    DownsampledImage(media: item.mediaItem)
                        .isResizable()
                        .frame(height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                        .shadow(color: .darkShadow, radius: 6)
                    VStack(alignment: .leading, spacing: 0) {
                        Text(item.identifier)
                            .fontWeight(.medium)
                        Text(item.timestamp.string("dd-MM-yyyy"))
                            .foregroundColor(.gray)
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    Spacer()
                }.padding(7)
                    .background {
                        Color.basic.opacity(0.6)
                            .background(Color.background)
                    }.clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: .darkShadow, radius: 6, y: 8)
            }
        }.buttonStyle(.plain)
        .onSwipe(width: 50, isEnabled: !editMode, shape: RoundedRectangle(cornerRadius: 16, style: .continuous)) {
            Button(action: {
                withAnimation(.easeInOut) {
                    item.delete()
                }
            }) {
                Image(systemName: "trash.fill")
                    .font(.body.weight(.semibold))
            }.swipeContent(edge: .trailing)
            .with(tint: .red)
            .shape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .frame(height: 62)
            Button(action: {
                withAnimation(.easeInOut) {
                    var newItem = item
                    newItem.isPinned.toggle()
                    newItem.update()
                }
            }) {
                Image(systemName: item.isPinned ? "pin.slash.fill": "pin.fill")
                    .font(.body.weight(.semibold))
            }.swipeContent(edge: .leading)
            .with(tint: .yellow)
            .shape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .frame(height: 62)
        }.frame(height: 62)
        .listRowInsets(EdgeInsets(top: 6, leading: 20, bottom: 6, trailing: 20))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .contextMenu(menuItems: {
            Button(action: {
                withAnimation(.easeInOut) {
                    var newItem = item
                    newItem.isPinned.toggle()
                    newItem.update()
                }
            }) {
                Label(item.isPinned ? "Unpin": "Pin", systemImage: item.isPinned ? "pin.slash.fill": "pin.fill")
            }
            Divider()
            Button(role: .destructive, action: {
                withAnimation(.easeInOut) {
                    item.delete()
                }
            }) {
                Label("Delete", systemImage: "trash.fill")
            }
        }) {
            Text("")//preview
        }
    }
}
