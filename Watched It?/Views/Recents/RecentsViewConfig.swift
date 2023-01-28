//
//  RecentsViewConfig.swift
//  Watched It?
//
//  Created by Joe Maghzal on 10/01/2023.
//

import Foundation

struct RecentsViewConfig {
//MARK: - Properties
    var rawItems = [IdentifiedItem]()
    var selectedItems = [IdentifiedItem]()
    var editMode = false
    var items: [RecentItem] {
        return [RecentItem.pinned(rawItems.filter({$0.isPinned})), RecentItem.unpinned(rawItems.filter({!$0.isPinned}))]
    }
//MARK: - Functions
    mutating func selectAll() {
        editMode = true
        selectedItems.isEmpty ? selectedItems = rawItems: selectedItems.removeAll()
    }
    mutating func toggleEdit() {
        editMode.toggle()
        selectedItems.removeAll()
    }
    mutating func delete() {
        selectedItems.forEach { item in
            item.delete()
        }
        selectedItems.removeAll()
    }
}

enum RecentItem: Identifiable {
    case pinned([IdentifiedItem])
    case unpinned([IdentifiedItem])
    var title: String {
        switch self {
            case .pinned:
                return "Pinned"
            case .unpinned:
                return "Recents"
        }
    }
    var items: [IdentifiedItem] {
        switch self {
            case .pinned(let items), .unpinned(let items):
                return items
        }
    }
    var id: String {
        return title
    }
}
