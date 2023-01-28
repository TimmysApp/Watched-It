//
//  CreditsDetailsViewConfig.swift
//  Watched It?
//
//  Created by Joe Maghzal on 15/01/2023.
//

import Foundation

struct CreditsDetailsViewConfig {
//MARK: - Properties
    var isCast = true
    var credits: Credits
//MARK: - Functions
    func data(_ isCast: Bool) -> [CreditsPreview] {
        return isCast ? credits.cast.map(\.preview): credits.crew.map(\.preview)
    }
//MARK: - Initializer
    init(credits: Credits) {
        self.credits = credits
    }
}
