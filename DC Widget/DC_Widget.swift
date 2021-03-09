//
//  DC_Widget.swift
//  DC Widget
//
//  Created by Luca Lo Forte on 9/3/21.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct DC_WidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        if self.family == .systemSmall {
            smallContent
        } else {
            mediumContent
        }
       
    }
    
    var smallContent : some View {
        VStack(alignment: .leading, spacing: 4){
            Text("Newest")
                .font(Font.footnote.smallCaps())
                .foregroundColor(.secondary)
            
            Text("Matched Geometry Effect")
                .font(.subheadline)
                .fontWeight(.bold)
            
            Text("Learn how to quickly transition different views")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding(12)
    }
    
    var mediumContent : some View {
        VStack(alignment: .leading, spacing: 8){
            Text("Newest")
                .font(Font.footnote.smallCaps())
                .foregroundColor(.secondary)
            
            ForEach(courseSections.indices, id: \.self) { index in
                if index < 2 {
                    CourseRow(courseSection: courseSections[index])
                }
            }
        }
        .padding(12)
    }
    
}

@main
struct DC_Widget: Widget {
    let kind: String = "DC_Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            DC_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("DC")
        .description("Design code widget")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct DC_Widget_Previews: PreviewProvider {
    static var previews: some View {
        DC_WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
