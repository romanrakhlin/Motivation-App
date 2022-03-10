//
//  QuotesAppWidget.swift
//  QuotesAppWidget
//
//  Created by Roman Rakhlin on 01.11.2021.
//

import WidgetKit
import SwiftUI
import Intents
import QuotesAppService

struct Provider: TimelineProvider {
    
    let service = QuoteService()
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), quote: service.getRandomQuote())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        for hourOffset in 0 ..< 24 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let quote =  service.getRandomQuote()
            var entry = SimpleEntry(date: entryDate, quote: quote)
            entry.colors = service.getColors(quote)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }


    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), quote: service.getRandomQuote())
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let quote: Quote
    var colors: [Color] = [Color.black, Color.black]
}

struct WidgetQuoteView: View {
    var quote: Quote
    
    var body: some View {
        VStack(alignment: .center) {
            Text(getQuoteAndAuthor(quote: quote).0)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .shadow(color: .black, radius: 2)
            Text(getQuoteAndAuthor(quote: quote).1)
                .font(.system(size: 16, weight: .light, design: .rounded))
                .shadow(color: .black, radius: 2)
        }
        .padding()
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
    }
    
    func getQuoteAndAuthor(quote: Quote) -> (String, String) {
        let components = quote.quote.components(separatedBy: "—")
        return (components[0], components[1])
    }
}

struct QuoteShuffleWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        WidgetQuoteView(quote: entry.quote)
    }
}

@main
struct QuoteShuffleWidget: Widget {
    
    let backgrounds: [String] = ["back-1", "back-2", "back-3", "back-4", "back-5", "back-6", "back-7", "back-8", "back-9", "back-10", "back-11", "back-12", "back-13", "back-14", "back-15", "back-16", "back-17", "back-18", "back-20", "back-21", "back-22", "back-23", "back-24", "back-25", "back-26", "back-27", "back-28", "back-29", "back-30", "back-31", "back-32", "back-33", "back-34", "back-35", "back-36", "back-37", "back-38"]
    
    let kind: String = "QuoteShuffleWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            QuoteShuffleWidgetEntryView(entry: entry)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    ZStack {
                        Image(backgrounds.randomElement() ?? "back-0")
                            .resizable()
                            .scaledToFill()
                    }
                )
        }
        .supportedFamilies([.systemMedium, .systemLarge])
        .configurationDisplayName("Motivation Widget")
        .description("Shows wonderful and fresh quotes")
    }
}

struct QuoteShuffleWidget_Previews: PreviewProvider {
    static var previews: some View {
        QuoteShuffleWidgetEntryView(entry: SimpleEntry(date: Date(), quote: QuoteService().getRandomQuote()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
