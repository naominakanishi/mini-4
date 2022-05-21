import SwiftUI
import Academy

public struct CalendarEventBox: View {
    var event: CalendarEvent
    
    public init(event: CalendarEvent) {
        self.event = event
    }
    
    public var body: some View {
        VStack {
            HStack {
                Text(event.emoji)
                    .font(.system(size: 40, weight: .regular, design: .default))
                    .padding()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.title)
                        .font(.system(size: 18, weight: .bold, design: .default))
                    
                    Text(event.startDate.getFormattedDate())
                        .font(.system(size: 14, weight: .regular, design: .default))
                }
                
                Spacer()
            }
        }
        .background(Color.adaLightBlue.opacity(0.5))
        .foregroundColor(Color.white)
        .cornerRadius(16)
    }
}

struct CalendarEventBox_Previews: PreviewProvider {
    static var previews: some View {
        CalendarEventBox(event: CalendarEvent(id: "x", title: "Yoga", emoji: "🚀", fullDay: false, startDateTimeInterval: Date().timeIntervalSince1970, endDateTimeInterval: Date().timeIntervalSince1970))
    }
}
