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
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    
    var favoriteEmoji: String
}

struct ChangeContactIntent: AppIntent {
    static var title: LocalizedStringResource = "Change Contact"
    
    @Parameter(title: "Contact index")
    var index : Int
    
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
