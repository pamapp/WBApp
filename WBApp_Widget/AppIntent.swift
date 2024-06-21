//
//  AppIntent.swift
//  WBApp_Widget
//
//  Created by Alina Potapova on 17.06.2024.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("Select contacts to display in the widget.")
    
    @Parameter(title: "Contacts")
    var contactNames: [String]
    
    // Маппинг имен контактов в ID
    var contactIdMapping: [String: String] {
        var mapping = [String: String]()
        for contact in SharedData.shared.contacts {
            mapping[contact.name] = contact.id.uuidString
        }
        return mapping
    }
    
    // Конструкторы
    init() {
        self.contactNames = SharedData.shared.contacts.map { $0.name }
    }
    
    init(names: [String]) {
        self.contactNames = names
    }
    
    // Получение ID выбранных контактов
    var selectedContactIds: [String] {
        contactNames.compactMap { contactIdMapping[$0] }
    }
}

struct ChangeContactIntent: AppIntent {
    static var title: LocalizedStringResource = "Change Contact"
    
    @Parameter(title: "Contact index") var index : Int
    
    init() {
    }
    
    init(index: Int) {
        self.index = index
    }
    
    func perform() async throws -> some IntentResult {
        SharedData.shared.currentContactIndex = index

        return .result()
    }
}
