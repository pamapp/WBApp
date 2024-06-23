//
//  String+Extesions.swift
//  WBApp
//
//  Created by Alina Potapova on 23.06.2024.
//

import Foundation

extension String.StringInterpolation {
    mutating func appendInterpolation(_ date: Date, locale: Locale, style: DateFormatter.Style) {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateStyle = style
        let formatterDate = formatter.string(from: date)
        appendLiteral(formatterDate)
    }
    
    mutating func appendInterpolation(spellOut date: Date, locale: Locale) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: date)

        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .spellOut

        if let day = components.day, let month = components.month, let year = components.year {
            let dayString = formatter.string(from: NSNumber(value: day)) ?? "\(day)"
            let monthString = formatter.string(from: NSNumber(value: month)) ?? "\(month)"
            let yearString = formatter.string(from: NSNumber(value: year)) ?? "\(year)"

            let formattedDate = "\(dayString) \(monthString), \(yearString)"
            appendLiteral(formattedDate)
        } else {
            appendLiteral("Invalid date")
        }
    }
}
