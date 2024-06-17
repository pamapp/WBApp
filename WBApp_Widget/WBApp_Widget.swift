//
//  WBApp_Widget.swift
//  WBApp_Widget
//
//  Created by Alina Potapova on 17.06.2024.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> ToDoEntry {
        ToDoEntry(contactToDisplay: Array(SharedData.shared.contacts), currentContactIndex: SharedData.shared.currentContactIndex, configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> ToDoEntry {
        ToDoEntry(contactToDisplay: Array(SharedData.shared.contacts), currentContactIndex: SharedData.shared.currentContactIndex, configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<ToDoEntry> {
        // Get data from database
        let toDisplay = Array(SharedData.shared.contacts)
        
        let timeline = Timeline(entries: [ToDoEntry(contactToDisplay: toDisplay, currentContactIndex: SharedData.shared.currentContactIndex, configuration: configuration)], policy: .atEnd)
        return timeline
    }
}

struct ToDoEntry: TimelineEntry {
    var date: Date = .now
    var contactToDisplay : [Contact]
    var currentContactIndex : Int
    let configuration: ConfigurationAppIntent
}

struct WBApp_WidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry

    var body: some View {
        switch family {
        case .systemSmall:
            SmallView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        case .systemMedium:
            MediumView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        case .systemLarge:
            MediumView(entry: entry)
        case .systemExtraLarge:
            MediumView(entry: entry)

        case .accessoryCircular:
            MediumView(entry: entry)

        case .accessoryRectangular:
            MediumView(entry: entry)

        case .accessoryInline:
            MediumView(entry: entry)

        @unknown default:
            MediumView(entry: entry)
        }
    }
}
struct MediumView: View {
    var entry: Provider.Entry

    var body: some View {
        
        VStack {
            Text(entry.contactToDisplay[entry.currentContactIndex].name)
                .font(.headline)
            
            HStack {
                Button(intent: ChangeContactIntent(index: (entry.currentContactIndex - 1 + entry.contactToDisplay.count) % entry.contactToDisplay.count)) {
                    Text("<<")
                        .foregroundStyle(.red)
                }.buttonStyle(.plain)
                
                Spacer()
                
                Button(intent: ChangeContactIntent(index: (entry.currentContactIndex + 1) % entry.contactToDisplay.count)) {
                    Text(">>")
                        .foregroundStyle(.red)
                }.buttonStyle(.plain)
            }
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
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    WBApp_Widget()
} timeline: {
    ToDoEntry(contactToDisplay: Array(SharedData.shared.contacts), currentContactIndex: 0, configuration: .smiley)
    ToDoEntry(contactToDisplay: Array(SharedData.shared.contacts), currentContactIndex: 0, configuration: .smiley)
}

