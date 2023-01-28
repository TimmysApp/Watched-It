//
//  YouTubeView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 15/01/2023.
//

import SwiftUI
import AVKit
import YouTubePlayerKit

struct YouTubeView: View {
    var player: YouTubePlayer
    init(id: String) {
        let player = YouTubePlayer()
        player.load(source: .video(id: id))
        player.configuration.autoPlay = false
        self.player = player
    }
    var body: some View {
        YouTubePlayerView(player)
    }
}
