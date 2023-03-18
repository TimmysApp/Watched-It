//
//  RemoteImage.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import SwiftUI
import NukeUI

public struct RemoteImage: View {
//MARK: - Properties
    private var placeholder: AnyView?
    private var loading: AnyView?
    private var url: URL?
//MARK: - Initializers
    public init(url: String?) {
        if let url {
            self.url = URL(string: url)
        }
    }
    public init(url: URL?) {
        self.url = url
    }
    private init(url: URL?, placeholder: AnyView?, loading: AnyView?) {
        self.url = url
        self.placeholder = placeholder
        self.loading = loading
    }
//MARK: - Body
    public var body: some View {
        if let url {
            LazyImage(url: url) { state in
                if let result = state.result {
                    switch result {
                        case .success(let success):
                            Image(uiImage: success.image)
                                .resizable()
                        case .failure:
                            placeholder
                    }
                }else {
                    loading ?? AnyView(Color.gray)
                }
            }
        }else {
            placeholder ?? AnyView(Color.gray)
        }
    }
}

//MARK: - Modifiers
public extension RemoteImage {
    func placeholder(@ViewBuilder placeholder: () -> some View) -> Self {
        return RemoteImage(url: url, placeholder: AnyView(placeholder()), loading: loading)
    }
    func onLoading(@ViewBuilder loading: () -> some View) -> Self {
        return RemoteImage(url: url, placeholder: placeholder, loading: AnyView(loading()))
    }
}
