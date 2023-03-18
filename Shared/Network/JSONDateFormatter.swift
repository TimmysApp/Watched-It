//
//  JSONDateFormatter.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation

class JSONDateFormatter: DateFormatter {
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    override func date(from string: String) -> Date? {
        if let date = dateFormatter.date(from: string) {
            return date
        }else {
            return Date()
        }
    }
}
