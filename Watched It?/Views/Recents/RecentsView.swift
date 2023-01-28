//
//  RecentsView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 10/01/2023.
//

import SwiftUI
import DataStruct

struct RecentsView: View {
    @State var config = RecentsViewConfig()
    var body: some View {
        NavigationStack {
            List {
                ForEach(config.items) { section in
                    Section(section.title) {
                        ForEach(section.items) { item in
                            RecentsCellView(selectedItems: $config.selectedItems, editMode: config.editMode, item: item)
                        }
                    }.hidden(section.items.isEmpty)
                }
            }.listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.background.gradient)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation() {
                            config.toggleEdit()
                        }
                    }) {
                        Text(config.editMode ? "Done": "Edit")
                            .fontWeight(.semibold)
                    }.disabled(config.rawItems.isEmpty)
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button(action: {
                        withAnimation() {
                            config.selectAll()
                        }
                    }) {
                        Text(config.selectedItems.isEmpty ? "Select All": "Unselect All")
                            .fontWeight(.semibold)
                    }.disabled(config.rawItems.isEmpty)
                    Spacer()
                    Button(action: {
                        withAnimation() {
                            config.delete()
                        }
                    }) {
                        Image(systemName: "trash.fill")
                            .foregroundColor(.red)
                    }.hidden(config.selectedItems.isEmpty)
                }
            }.navigationTitle(Text("Recents"))
            .fetch(IdentifiedItem.self, config: $config, for: \.rawItems)
        }
    }
}

struct RecentsView_Previews: PreviewProvider {
    static var previews: some View {
        RecentsView()
    }
}
