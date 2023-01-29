//
//  SearchBarView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 11/01/2023.
//

import SwiftUI
import STools

struct SearchBarView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var isSearching: Bool
    @FocusState var isFocused
    var placeholder: String
    var withFocus = true
    @Binding var searchText: String
    var body: some View {
        HStack {
            TextField(placeholder, text: $searchText)
                .disabled(!withFocus)
                .stateModifier(withFocus) { view in
                    view
                        .focused($isFocused)
                }.frame(height: 25)
                .padding(7)
                .padding(.leading, 10)
                .padding([.leading, .trailing], 20)
                .background(colorScheme == .dark ? Color(UIColor.systemGray6): .white)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .overlay (
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 10)
                        if isSearching && !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing, 10)
                        }
                    }
                ).padding(.horizontal, 10)
                .onTapGesture {
                    withAnimation() {
                        isFocused = true
                        isSearching = true
                    }
                }
            if isSearching {
                Button(action: {
                    withAnimation() {
                        searchText = ""
                        isFocused = false
                        isSearching = false
                    }
                }) {
                    Text("Cancel")
                        .fontWeight(.medium)
                        .foregroundColor(.accentColor)
                        .padding(.trailing)
                }.padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.easeInOut(duration: 0.5))
            }
        }.onChange(of: isSearching) { newValue in
            isFocused = newValue
        }.onAppear {
            isFocused = isSearching
        }
    }
}
