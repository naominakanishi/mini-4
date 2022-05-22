import SwiftUI

public struct MonthView: View {
    let month: MonthModel
    let trailingView: AnyView
    
    public init(month: MonthModel) {
        self.init(month: month) {
            EmptyView()
        }
    }
    
    public init<V>(month: MonthModel, trailingView: () -> V) where V: View {
        self.month = month
        self.trailingView = AnyView(trailingView())
    }
    
    public var body: some View {
        VStack {
            HStack {
                Text(month.name)
                    .font(.adaFontSubtitle)
                    .foregroundColor(Color.white)
                Spacer()
                trailingView
            }
            ForEach(month.days) { day in
                DayEventsView(model: day)
            }
        }
    }
}

public struct DayEventsView: View {
    let model: DayModel
    
    public init(model: DayModel) {
        self.model = model
    }
    
    public var body: some View {
        HStack {
            VStack {
                Text(model.name)
                    .font(.adaTagTitle)
                Text(model.number)
                    .font(.calendarDayOfTheMonth)
                Spacer()
            }
            VStack {
                ForEach(model.events) { event in
                    buildEventCard(event)
                }
            }
        }
        .padding(.all, DesignSystem.Spacing.cardInternalPadding)
        .background(Color.white.opacity(0.6).textFieldAdaGradient())
        .cornerRadius(12)
    }
    
    @ViewBuilder
    private func buildEventCard(_ event: EventModel) -> some View {
        HStack {
            Text(event.emoji)
                .font(.system(size: 24, weight: .regular, design: .default))
                .padding()
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.system(size: 14, weight: .bold, design: .default))
                if let time = event.time {
                    Text(time)
                        .font(.system(size: 13, weight: .regular, design: .default))
                }
            }
            Spacer()
        }
        .background(Color.adaLightBlue.textFieldAdaGradient())
        .foregroundColor(Color.white)
        .cornerRadius(16)
    }
}

public struct MonthModel: Identifiable {
    public let id = UUID()
    let name: String
    let days: [DayModel]
    
    public init(name: String, days: [DayModel]) {
        self.name = name
        self.days = days
    }
}

public struct DayModel: Identifiable {
    public let id = UUID()
    let name: String
    let number: String
    let events: [EventModel]
    
    public init(name: String, number: String, events: [EventModel]) {
        self.name = name
        self.number = number
        self.events = events
    }
    
}

public struct EventModel: Identifiable {

    public let id = UUID()
    let title: String
    let color: Color
    let emoji: String
    let time: String?
    
    public init(title: String, color: Color, emoji: String, time: String?) {
        self.title = title
        self.color = color
        self.emoji = emoji
        self.time = time
    }
}
