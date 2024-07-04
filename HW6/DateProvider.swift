//
//  DateProvider.swift
//  WBApp
//
//  Created by Alina Potapova on 25.06.2024.
//

import Foundation

struct DateInfo: Identifiable {
    let id = UUID()
    var dateName: String = ""
    var date: String = ""
    var isSelected: Bool = false
}

class DateProvider {
    func createDates(from date: Date, language: Language, isSpellOut: Bool, style: DateFormatter.Style) -> [DateInfo] {
        let calendar = Calendar.current
        let dayOffsets = [-2, -1, 0, 1, 2]
        
        return dayOffsets.enumerated().map { index, offset in
            guard let newDate = calendar.date(byAdding: .day, value: offset, to: date) else { return DateInfo() }
            let localizedDayName = language.dayNames[index]
            
            return DateInfo(dateName: "\(localizedDayName)",
                            date: isSpellOut ? "\(spellOut: newDate, locale: language.locale, style: style)" : "\(newDate, locale: language.locale, style: style)",
                            isSelected: index == 2)
        }
    }
}
