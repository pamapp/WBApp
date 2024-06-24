//
//  StringInterpolation.swift
//  WBApp
//
//  Created by Alina Potapova on 23.06.2024.
//

import SwiftUI

enum Language: String, CaseIterable {
    case en = "🇺🇸"
    case fr = "🇫🇷"
    case ru = "🇷🇺"
    case zh = "🇨🇳"
    case es = "🇪🇸"
    
    var locale: Locale {
        switch self {
        case .en: return Locale(identifier: "en_US")
        case .fr: return Locale(identifier: "fr_FR")
        case .ru: return Locale(identifier: "ru_RU")
        case .zh: return Locale(identifier: "zh_CN")
        case .es: return Locale(identifier: "es_ES")
        }
    }
    
    var dayNames: [String] {
        switch self {
        case .en: return ["Day before yesterday", "Yesterday", "Today", "Tomorrow", "Day after tomorrow"]
        case .fr: return ["Avant-hier", "Hier", "Aujourd'hui", "Demain", "Après-demain"]
        case .ru: return ["Позавчера", "Вчера", "Сегодня", "Завтра", "Послезавтра"]
        case .zh: return ["前天", "昨天", "今天", "明天", "后天"]
        case .es: return ["Anteayer", "Ayer", "Hoy", "Mañana", "Pasado mañana"]
        }
    }
}

struct StringInterpolationView: View {
    @State private var selectedDate = Date()
    @State private var selectedLanguage = Language.ru
    @State private var isSpellOut = false

    private let dateStyle: DateFormatter.Style = .long

    var body: some View {
        VStack(spacing: 16) {
            List(createDates(from: selectedDate), id: \.self) { dateText in
                Text(dateText)
                    .font(.subheadline)
                    .fontWeight(dateText.contains(selectedLanguage.dayNames[2]) ? .bold : .regular)

            }
            .listStyle(.plain)

            DatePicker(Constants.selectDate, selection: $selectedDate, displayedComponents: [.date])
                .padding(.horizontal)

            Toggle(Constants.spellOut, isOn: $isSpellOut)
                .padding(.horizontal)
            
            Picker("", selection: $selectedLanguage) {
                ForEach(Language.allCases, id: \.self) { language in
                    Text(language.rawValue).tag(language)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            Spacer()
        }
        .padding()
    }
    
    private func createDates(from date: Date) -> [String] {
        let calendar = Calendar.current
        let dayOffsets = [-2, -1, 0, 1, 2]
        
        return dayOffsets.enumerated().map { index, offset in
            let newDate = calendar.date(byAdding: .day, value: offset, to: date)!
            let localizedDayName = selectedLanguage.dayNames[index]
            return "\(localizedDayName): \(isSpellOut ? "\(spellOut: newDate, locale: selectedLanguage.locale)" : "\(newDate, locale: selectedLanguage.locale, style: dateStyle)")"
        }
    }
}

extension StringInterpolationView {
    private enum Constants {
        static let selectDate: String = "Select a date"
        static let spellOut: String = "Spell Out"

        static let dayBeforeYesterday: String = "Day before yesterday"
        static let yesterday: String = "Yesterday"
        static let today: String = "Today"
        static let tomorrow: String = "Tomorrow"
        static let dayAfterTomorrow: String = "Day after tomorrow"
    }
}

#Preview {
    StringInterpolationView()
}

