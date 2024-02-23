import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        let sharedDefaults = UserDefaults(suiteName: "group.mag-isb.LifeQuotes.LifeQuote")

        let quoteText = sharedDefaults?.string(forKey: "quoteText") ?? "Default Quote"
        let imageName = sharedDefaults?.string(forKey: "imageName") ?? "image1" // Fallback image

        return SimpleEntry(date: Date(), backgroundImage: imageName, quote: quoteText)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let sharedDefaults = UserDefaults(suiteName: "group.mag-isb.LifeQuotes.LifeQuote")

        let quoteText = sharedDefaults?.string(forKey: "quoteText") ?? "Default Quote"
        let imageName = sharedDefaults?.string(forKey: "imageName") ?? "image1" // Fallback image

        let entry = SimpleEntry(date: Date(), backgroundImage: imageName, quote: quoteText)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let sharedDefaults = UserDefaults(suiteName: "group.mag-isb.LifeQuotes.LifeQuote")

        let quoteText = sharedDefaults?.string(forKey: "quoteText") ?? "Default Quote"
        let imageName = sharedDefaults?.string(forKey: "imageName") ?? "image1" // Fallback image

        if #available(iOS 16, *) {
            let entriesCount = context.family == .systemSmall ? 1 : 5

            var entries: [SimpleEntry] = []
            let currentDate = Date()

            // Generate entries for the desired count
            for hourOffset in 0..<entriesCount {
                let date = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                let entry = SimpleEntry(date: date, backgroundImage: imageName, quote: quoteText)
                entries.append(entry)
            }

            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        } else {
            // Handle cases where iOS version is below 16 (e.g., display a placeholder or message)
            completion(Timeline(entries: [], policy: .never))
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let backgroundImage: String
    let quote: String
}

struct QuotesEntryView: View {
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
                    .resizable()
                    .aspectRatio(contentMode: .fill)
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
    let sharedDefaults = UserDefaults(suiteName: "group.mag-isb.LifeQuotes.LifeQuote")
    let quoteText = sharedDefaults?.string(forKey: "quoteText") ?? "Default Quote"
    let imageName = sharedDefaults?.string(forKey: "imageName") ?? "image1"
    SimpleEntry(date: Date(), backgroundImage: imageName, quote: quoteText)
}

#Preview(as: .accessoryRectangular) {
    Quotes()
} timeline: {
    let sharedDefaults = UserDefaults(suiteName: "group.mag-isb.LifeQuotes.LifeQuote")
    let quoteText = sharedDefaults?.string(forKey: "quoteText") ?? "Default Quote"
    let imageName = sharedDefaults?.string(forKey: "imageName") ?? "image1"
    SimpleEntry(date: Date(), backgroundImage: imageName, quote: quoteText)
  
}
