//
//  PrefrencesView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 15/01/2023.
//

import SwiftUI

struct PrefrencesView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(PrefrenceItem.sections) { section in
                    Section(section.title) {
                        ForEach(section.items) { item in
                            NavigationLink(value: item) {
                                HStack {
                                    Image(systemName: item.image)
                                        .font(.body.weight(.medium))
                                        .foregroundColor(.white)
                                        .padding(4)
                                        .frame(width: 30, height: 30)
                                        .background(item.color)
                                        .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                    Text(item.title)
                                        .fontWeight(.medium)
                                    Spacer()
                                }
                            }
                        }.listRowBackground(Color.basic.opacity(0.5))
                    }
                }
            }.listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color.background.gradient)
            .navigationTitle(Text("Prefrences"))
        }
    }
}

enum PrefrenceItem: Int, Identifiable, CaseIterable, Hashable {
    case account, app, other, styling, privacy, about, termsConditions, privacyPolicy
    var id: Int {
        return rawValue
    }
    static let sections: [Self] = [.account, .app, .other]
    var title: String {
        switch self {
            case .account:
                return "Account"
            case .app:
                return "App"
            case .other:
                return "Other"
            case .styling:
                return "Styling"
            case .privacy:
                return "Privacy"
            case .about:
                return "About"
            case .termsConditions:
                return "Terms & Conditions"
            case .privacyPolicy:
                return "Privacy Policy"
        }
    }
    var image: String {
        switch self {
            case .styling:
                return "paintbrush"
            case .privacy:
                return "lock.rectangle.stack"
            case .about:
                return "info.circle"
            case .termsConditions:
                return "doc.append"
            case .privacyPolicy:
                return "lock.doc"
            default:
                return ""
        }
    }
    var color: Color {
        switch self {
            case .styling:
                return .pink
            case .privacy:
                return .gray
            case .about:
                return .black
            case .termsConditions:
                return .purple
            case .privacyPolicy:
                return .yellow
            default:
                return .clear
        }
    }
    var items: [Self] {
        switch self {
            case .account:
                return []
            case .app:
                return [.styling, .privacy, .about]
            case .other:
                return [.termsConditions, .privacyPolicy]
            default:
                return []
        }
    }
}
