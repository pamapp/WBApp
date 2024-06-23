//
//  StringInterpolation.swift
//  WBApp
//
//  Created by Alina Potapova on 23.06.2024.
//

import SwiftUI

struct StringIntepolationView: View {
    @State var selectedDate = Date()
    @State var selectedLocale = Locale.current
    @State var isSpellOut = false

    var dateStyle = DateFormatter.Style.long
    let locales: [Locale] = [
        Locale(identifier: "en_US"),
        Locale(identifier: "fr_FR"),
        Locale(identifier: "ru_RU"),
        Locale(identifier: "zh_CN"),
        Locale(identifier: "es_ES")
    ]
    
    let localeFlags = ["🇺🇸", "🇫🇷", "🇷🇺", "🇨🇳", "🇪🇸"]
    
    var body: some View {
        VStack {
            DatePicker("Select a date",selection: $selectedDate,displayedComponents: [.date])
                .padding()
            
            Picker("", selection: $selectedLocale) {
                ForEach(0..<locales.count, id: \.self) { i in
                    Text(self.localeFlags[i]).tag(self.locales[i])
                }
            }
            .pickerStyle(.segmented)
            .padding()

            let dates = createDates(from: selectedDate)
            
            List {
                ForEach(dates, id: \.self) { dateText in
                    Text(dateText)
                        .font(dateText.contains("Today") ? .subheadline.bold() : .subheadline)
                }
            }
            .listStyle(.plain)
            .font(.subheadline)
            
            Toggle("SpellOut", isOn: $isSpellOut)
                .padding()
            
            Spacer()
        }
    }
    
    private func createDates(from date: Date) -> [String] {
        let calendar = Calendar.current
        let dayOffsets = [-2,-1,0,1,2]
        let dayNames = ["Day before yesterday", "Yesterday", "Today", "Tomorrow", "Day after tomorrow"]
        
        return dayOffsets.enumerated().map { index, offset in
            let newDate = calendar.date(byAdding: .day, value: offset, to: date)!
            return "\(dayNames[index]): \(isSpellOut ? "\(spellOut: newDate, locale: selectedLocale)" : "\(newDate, locale: selectedLocale, style: dateStyle)")"
        }
    }
}

#Preview {
    StringIntepolationView()
}
