//
//  QuotesLiveActivity.swift
//  Quotes
//
//  Created by Mag isb-10 on 21/02/2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct QuotesAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct QuotesLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: QuotesAttributes.self) { context in
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

extension QuotesAttributes {
    fileprivate static var preview: QuotesAttributes {
        QuotesAttributes(name: "World")
    }
}

extension QuotesAttributes.ContentState {
    fileprivate static var smiley: QuotesAttributes.ContentState {
        QuotesAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: QuotesAttributes.ContentState {
         QuotesAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: QuotesAttributes.preview) {
   QuotesLiveActivity()
} contentStates: {
    QuotesAttributes.ContentState.smiley
    QuotesAttributes.ContentState.starEyes
}
