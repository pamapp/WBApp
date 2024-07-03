//
//  WBApp_Widget.swift
//  WBApp_Widget
//
//  Created by Alina Potapova on 17.06.2024.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry(contactToDisplay: SharedData.shared.contacts, currentContactIndex: SharedData.shared.currentContactIndex)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> WidgetEntry {
        WidgetEntry(contactToDisplay: SharedData.shared.contacts, currentContactIndex: SharedData.shared.currentContactIndex)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<WidgetEntry> {
        let timeline = Timeline(entries: [WidgetEntry(contactToDisplay: SharedData.shared.contacts, currentContactIndex: SharedData.shared.currentContactIndex)], policy: .atEnd)
        return timeline
    }
}

struct WidgetEntry: TimelineEntry {
    var date: Date = .now
    var contactToDisplay: [Contact]
    var currentContactIndex: Int
}

struct WBApp_WidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry

    var body: some View {
        switch family {
        case .systemSmall:
            WBApp_WidgetSmallView(entry: entry)
        case .systemMedium:
            WBApp_WidgetMediumView(entry: entry)
        case .systemLarge:
            WBApp_WidgetMediumView(entry: entry)
        case .systemExtraLarge:
            WBApp_WidgetMediumView(entry: entry)
        case .accessoryCircular:
            WBApp_WidgetMediumView(entry: entry)
        case .accessoryRectangular:
            WBApp_WidgetMediumView(entry: entry)
        case .accessoryInline:
            WBApp_WidgetMediumView(entry: entry)
        @unknown default:
            WBApp_WidgetMediumView(entry: entry)
        }
    }
}

struct WBApp_Widget: Widget {
    @Environment(\.widgetFamily) var family
    let kind: String = "WBApp_Widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WBApp_WidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemExtraLarge) {
    WBApp_Widget()
} timeline: {
    WidgetEntry(contactToDisplay: Array(SharedData.shared.contacts), currentContactIndex: 0)
    WidgetEntry(contactToDisplay: Array(SharedData.shared.contacts), currentContactIndex: 0)
}

