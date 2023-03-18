//
//  SearchBarView.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import SwiftUI
import STools

struct SearchBarView: View {
    @FocusState private var isFocused
    @Binding var searchText: String
    @Binding var isSearching: Bool
    var isLoading = false
    var placeholder: String
    var body: some View {
        HStack {
            TextField(placeholder, text: $searchText)
                .focused($isFocused)
                .padding(7)
                .frame(height: 45)
                .padding(.leading, 10)
                .padding([.leading, .trailing], 20)
                .background(Color.basic.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .overlay (
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        ProgressView()
                            .hidden(!isLoading)
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                        }.hidden(!isSearching && searchText.isEmpty)
                    }.padding(.horizontal, 10)
                ).onTapGesture {
                    withAnimation() {
                        isFocused = true
                        isSearching = true
                    }
                }
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
            }.transition(.move(edge: .trailing))
            .animation(.easeInOut(duration: 0.5), value: isSearching)
            .hidden(!isSearching)
        }.onChange(of: isSearching) { newValue in
            isFocused = newValue
        }
    }
}
