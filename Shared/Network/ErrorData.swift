//
//  ErrorData.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation
import NetworkUI
import WatchedItModels

struct ErrorData: Errorable {
    var id = UUID()
    var networkError: NetworkError {
        NetworkError(title: message, body: summary)
    }
    var message: String?
    var summary: String?
    var action: Actions?
    enum CodingKeys: CodingKey {
        case message, summary, action
    }
}
