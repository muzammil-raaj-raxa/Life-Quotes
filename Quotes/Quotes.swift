//
//  LifeQuote.swift
//  LifeQuote
//
//  Created by Mag isb-10 on 20/02/2024.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
      SimpleEntry(date: Date(), backgroundImage: "image1", quote: "Do or Die")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
      let entry = SimpleEntry(date: Date(), backgroundImage: "image1", quote: "Do or Die")
          completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
          _ = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: Date(), backgroundImage: "image1", quote: "Do or Die")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let backgroundImage: String
  let quote: String
}


struct QuotesEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall, .systemMedium, .systemLarge:
            VStack(alignment: .center) {
                Text(entry.quote)
                    .font(.title)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(
                Image(entry.backgroundImage)
                    .aspectRatio(contentMode: .fill)
                    .scaledToFill()
            )
        case .accessoryInline:
            Text(entry.quote)
                .font(.title)
                .foregroundColor(.white)
        case .accessoryRectangular:
            Text(entry.quote)
            .foregroundColor(Color.primary)
        @unknown default:
            EmptyView()
        }
    }
}


struct Quotes: Widget {
    let kind: String = "LifeQuote"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                QuotesEntryView(entry: entry)
                    .containerBackground(.clear, for: .widget)
            } else {
              QuotesEntryView(entry: entry)
                    .padding(0)
                    .background(Color.clear)
            }
        }
        .configurationDisplayName("Life Quotes 🪶")
        .description("Quotes about life lessons.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .accessoryInline, .accessoryRectangular])
    }

}

#Preview(as: .systemSmall) {
    Quotes()
} timeline: {
  SimpleEntry(date: Date(), backgroundImage: "image1", quote: "Do or Die")
}

#Preview(as: .accessoryRectangular) {
    Quotes()
} timeline: {
  SimpleEntry(date: Date(), backgroundImage: "image1", quote: "Do or Die")
}
