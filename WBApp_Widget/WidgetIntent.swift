//
//  WidgetIntent.swift
//  WBApp_Widget
//
//  Created by Alina Potapova on 17.06.2024.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    
    static var description = IntentDescription("Show avatar full screen")

    @Parameter(title: "Con")
    var fullScreen: Bool
}


struct ChangeContactIntent: AppIntent {
    static var title: LocalizedStringResource = "Change Contact"
    
    @Parameter(title: "Contact index") var index : Int
    
    init() {}
    
    init(index: Int) {
        self.index = index
    }
    
    func perform() async throws -> some IntentResult {
        SharedData.shared.currentContactIndex = index

        return .result()
    }
}
