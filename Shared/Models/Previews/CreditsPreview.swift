//
//  CreditsPreview.swift
//  Watched It?
//
//  Created by Joe Maghzal on 15/01/2023.
//

import Foundation


struct CreditsPreview: Identifiable, Equatable, Hashable {
//MARK: - Properties
    var id = UUID()
    var name: String
    var job: String
    var department: String?
    var url: URL?
    var type: PreviewType
//MARK: - Types
    enum PreviewType: Hashable, CaseIterable, Identifiable {
        case cast(id: Int)
        case crew(id: Int)
        static let allCases = [CreditsPreview.PreviewType.cast(id: 0), CreditsPreview.PreviewType.crew(id: 0)]
        var isCast: Bool {
            switch self {
                case .cast:
                    return true
                case .crew:
                    return false
            }
        }
        var id: Bool {
            return isCast
        }
    }
}
