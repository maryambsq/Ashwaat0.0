//
//  TawafWidgetLiveActivityLiveActivity.swift
//  TawafWidgetLiveActivity
//
//  Created by ALJOAHARAH SAUD ALSAYARI on 05/05/2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TawafWidgetLiveActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct TawafWidgetLiveActivityLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TawafWidgetLiveActivityAttributes.self) { context in
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

extension TawafWidgetLiveActivityAttributes {
    fileprivate static var preview: TawafWidgetLiveActivityAttributes {
        TawafWidgetLiveActivityAttributes(name: "World")
    }
}

extension TawafWidgetLiveActivityAttributes.ContentState {
    fileprivate static var smiley: TawafWidgetLiveActivityAttributes.ContentState {
        TawafWidgetLiveActivityAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: TawafWidgetLiveActivityAttributes.ContentState {
         TawafWidgetLiveActivityAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: TawafWidgetLiveActivityAttributes.preview) {
   TawafWidgetLiveActivityLiveActivity()
} contentStates: {
    TawafWidgetLiveActivityAttributes.ContentState.smiley
    TawafWidgetLiveActivityAttributes.ContentState.starEyes
}
