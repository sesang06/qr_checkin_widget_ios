//
//  widget.swift
//  widget
//
//  Created by sesang on 2021/07/21.
//

import WidgetKit
import SwiftUI
import Intents
import WebKit
struct Provider: IntentTimelineProvider {

    func placeholder(in context: Context) -> SimpleEntry {
      
        return SimpleEntry(date: Date())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        
             let entry = SimpleEntry(date: Date())
             completion(entry)
       
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
//
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset, to: currentDate)!

            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
//        return
//        var entries = [SimpleEntry]()
////                let currentDate = Date()
//        let currentDate = Date()
//               let midnight = Calendar.current.startOfDay(for: currentDate)
//               let nextMidnight = Calendar.current.date(byAdding: .day, value: 1, to: midnight)!
//
//               for offset in 0 ..< 60 * 24 * 60{
//                   let entryDate = Calendar.current.date(byAdding: .second, value: offset, to: midnight)!
//                   entries.append(SimpleEntry(date: entryDate))
//               }
//        let timeline = Timeline(entries: entries, policy: .after(nextMidnight))
//              completion(timeline)
//
    }
}



struct NetworkImage: View {
  var body: some View {

    Group {
        if let uiImage = CheckinDownloader().fetchUIImage() {

       Image(uiImage: uiImage)
         .resizable()
         .aspectRatio(contentMode: .fill)
      }
      else {
       Image("placeholder-image")
      }
    }
  }

}
struct SimpleEntry: TimelineEntry {
    var date: Date
    
}

struct widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {

        NetworkImage()
    }
}

@main
struct widget: Widget {
    let kind: String = "widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            widgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

