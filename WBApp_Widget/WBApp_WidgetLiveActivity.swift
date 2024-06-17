//
//  WBApp_WidgetLiveActivity.swift
//  WBApp_Widget
//
//  Created by Alina Potapova on 17.06.2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WBApp_WidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WBApp_WidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WBApp_WidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension WBApp_WidgetAttributes {
    fileprivate static var preview: WBApp_WidgetAttributes {
        WBApp_WidgetAttributes(name: "World")
    }
}

extension WBApp_WidgetAttributes.ContentState {
    fileprivate static var smiley: WBApp_WidgetAttributes.ContentState {
        WBApp_WidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WBApp_WidgetAttributes.ContentState {
         WBApp_WidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WBApp_WidgetAttributes.preview) {
   WBApp_WidgetLiveActivity()
} contentStates: {
    WBApp_WidgetAttributes.ContentState.smiley
    WBApp_WidgetAttributes.ContentState.starEyes
}
