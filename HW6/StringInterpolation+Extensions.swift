//
//  StringInterpolation+Extensions.swift
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
    
    mutating func appendInterpolation(_ date: Date, locale: Locale) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.locale = locale
        formatter.doesRelativeDateFormatting = true
        appendLiteral(formatter.string(from: date))
    }
    
    mutating func appendInterpolation(spellOut date: Date, locale: Locale, style: DateFormatter.Style) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateStyle = style
        
        let dateComponents = dateFormatter.calendar.dateComponents([.day, .month, .year, .weekday], from: date)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        numberFormatter.locale = locale

        guard let day = dateComponents.day,
              let month = dateComponents.month,
              let year = dateComponents.year else {
            appendLiteral("")
            return
        }
        
        guard let dayString = numberFormatter.string(from: NSNumber(value: day)),
              var monthString = numberFormatter.string(from: NSNumber(value: month)),
              let yearStringFull = numberFormatter.string(from: NSNumber(value: year)),
              let yearStringShort = numberFormatter.string(from: NSNumber(value: year % 100)) else {
            appendLiteral("")
            return
        }
        
        let weekdayString: String

        if style == .short {
            monthString = numberFormatter.string(from: NSNumber(value: month))!
        } else {
            dateFormatter.dateFormat = "MMMM"
            monthString = dateFormatter.string(from: date)
        }
      
        if style == .full {
            dateFormatter.dateFormat = "EEEE"
            weekdayString = dateFormatter.string(from: date)
        } else {
            weekdayString = ""
        }

        var formattedDate: String
        
        switch (locale.identifier, style) {
        case ("en_US", .short):
            formattedDate = "\(monthString) \(dayString) \(yearStringShort)"
        case ("en_US", .medium), ("en_US", .full):
            formattedDate = "\(weekdayString) \(monthString) \(dayString) \(yearStringFull)"
        case ("es_ES", .short):
            formattedDate = "\(dayString) \(monthString) \(yearStringShort)"
        case ("es_ES", .medium), ("es_ES", .full):
            formattedDate = "\(weekdayString) \(dayString) \(monthString) \(yearStringFull)"
        case ("fr_FR", _), ("ru_RU", _):
            formattedDate = "\(weekdayString) \(dayString) \(monthString) \(yearStringFull)"
        case ("zh_CN", _):
            formattedDate = "\(yearStringFull) \(monthString) \(dayString) \(weekdayString)"
        default:
            formattedDate = "\(dayString) \(monthString) \(yearStringFull)"
        }
        
        appendLiteral(formattedDate)
    }
}
