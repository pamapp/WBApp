//
//  DatesScreen.swift
//  WBApp
//
//  Created by Alina Potapova on 23.06.2024.
//

import SwiftUI

enum DateStyle: String, CaseIterable {
    case short = "Short"
    case medium = "Medium"
    case full = "Full"
    
    var formatterStyle: DateFormatter.Style {
        switch self {
        case .short: return .short
        case .medium: return .medium
        case .full: return .full
        }
    }
}
    
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

struct DatesScreen: View {
    @State private var selectedDate = Date()
    @State private var selectedLanguage = Language.ru
    @State private var selectedDateStyle = DateStyle.full
    @State private var isSpellOut = true

    private let dateProvider = DateProvider()

    var body: some View {
        let dates = dateProvider.createDates(
                        from: selectedDate,
                        language: selectedLanguage,
                        isSpellOut: isSpellOut,
                        style: selectedDateStyle.formatterStyle
                    )
        
        VStack(spacing: 16) {
            DatesListView(dates: dates)

            DatePicker("Select a date", selection: $selectedDate, displayedComponents: [.date])
                .padding(.horizontal)
            
            Toggle("Spell Out", isOn: $isSpellOut)
                .padding(.horizontal)
            
            Picker("", selection: $selectedLanguage) {
                ForEach(Language.allCases, id: \.self) { language in
                    Text(language.rawValue).tag(language)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            Picker("", selection: $selectedDateStyle) {
                ForEach(DateStyle.allCases, id: \.self) { style in
                    Text(style.rawValue).tag(style)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
        .padding()
    }
}

struct DatesListView: View {
    let dates: [DateInfo]

    var body: some View {
        List(dates) { date in
            DateRowView(
                dateName: date.dateName,
                date: date.date,
                isSelected: date.isSelected
            )
        }
        .listStyle(.plain)
    }
}

struct DateRowView: View {
    let dateName: String
    let date: String
    let isSelected: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(dateName.capitalized)
                .font(.headline)
                .fontWeight(isSelected ? .bold : .regular)
            
            Text(date.trimmingCharacters(in: .whitespacesAndNewlines))
                .font(.headline)
                .fontWeight(isSelected ? .bold : .regular)
                .textSelection(.enabled)
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    DatesScreen()
}


