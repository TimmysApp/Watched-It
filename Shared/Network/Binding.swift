//
//  Binding.swift
//  Watched It?
//
//  Created by Joe Maghzal on 28/01/2023.
//

import SwiftUI
import NetworkUI

struct NetworkBindingViewModifier: ViewModifier {
    @EnvironmentObject var data: NetworkData
    @State var error: NetworkError?
    @State var isLoading = true
    var withPlaceholder = true
    func body(content: Content) -> some View {
        VStack {
            if isLoading && withPlaceholder {
                PlaceholderView()
            }else {
                content
                    .showLoading(isLoading)
            }
        }.sheet(item: $error) { error in
            ResultView(isError: true, title: error.title ?? "", summary: error.body ?? "")
        }.onChange(of: data.error) { newValue in
            guard newValue != nil, error == nil else {return}
            error = newValue
        }.onChange(of: data.isLoading) { newValue in
            guard newValue != isLoading else {return}
            isLoading = newValue
        }
    }
}
