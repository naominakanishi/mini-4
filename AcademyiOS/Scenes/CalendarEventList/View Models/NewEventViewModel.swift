import SwiftUI

final class NewEventViewModel: ObservableObject {
    
    @Published
    var title: String = ""
    
    @Published
    var isAllDay = false
    
    @Published
    var startDate: Date = .now
    @Published
    var endDate: Date = .now
    
    @Published
    var repeatingFrequency: String?
    
    var availableDateComponents: DatePickerComponents {
        if isAllDay {
            return [
                .date
            ]
        }
        return [
            .date,
            .hourAndMinute
                
        ]
    }

    var frequencyOptions: [String] {
        RepeatingFrequency.allCases.map { $0.rawValue }
    }
    
    func send() {
        
    }
}

enum RepeatingFrequency: String, CaseIterable {
    case never = "Nunca"
    case daily = "Todo dia"
    case weekly = "Toda semana"
    case everyTwoWeeks = "A cada duas semanas"
    case monthly = "Todo mês"
}
