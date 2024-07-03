//
//  Date+Extensions.swift
//  WBApp
//
//  Created by Alina Potapova on 15.06.2024.
//

import Foundation

extension Date {
    func dateToString(format: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = format
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
    
    var string: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
}
