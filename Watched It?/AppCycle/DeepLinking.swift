//
//  DeepLinking.swift
//  Watched It?
//
//  Created by Joe Maghzal on 30/01/2023.
//

import SwiftUI
import RegexBuilder

extension View {
    @ViewBuilder func handleURL(_ link: Binding<MediaPreview.PreviewType?>) -> some View {
        self
            .onOpenURL { url in
                guard link.wrappedValue == nil else {return}
                link.wrappedValue = LinkParser.parse(url)
            }
    }
}

struct LinkView: View {
    @State var newLink: MediaPreview.PreviewType?
    var link: MediaPreview.PreviewType
    var body: some View {
        NavigationStack {
            switch link {
                case .movie(let id):
                    MovieView(id: id)
                case .tvShow(let id):
                    TVShowView(id: id)
                case .person(let id):
                    PersonView(id: id)
            }
        }.onOpenURL { url in
            guard newLink == nil else {return}
            newLink = LinkParser.parse(url)
        }.fullScreenCover(item: $newLink) { item in
            LinkView(link: item)
        }
    }
}

struct LinkParser {
    let mediaSearch = Regex {
        "media?type="
        Capture {
            OneOrMore(.word)
        }
        
        "&id="
        TryCapture {
            OneOrMore(.digit)
        }transform: { match in
            Int(match)
        }
    }
    static func parse(_ url: URL) -> MediaPreview.PreviewType? {
        let instance = LinkParser()
        guard let details = url.absoluteString.components(separatedBy: "//").last, let mediaInfo = details.firstMatch(of: instance.mediaSearch), let type = MediaPreview.PreviewType(type: String(mediaInfo.1), id: Int(mediaInfo.2)) else {
            return nil
        }
        return type
    }
}
