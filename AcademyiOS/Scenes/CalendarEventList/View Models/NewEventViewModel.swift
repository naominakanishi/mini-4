import SwiftUI
import Academy
import Combine

final class NewEventViewModel: ObservableObject {
    
    private let eventSender = CalendarEventSenderService()
    
    private var cancelBag = [AnyCancellable]()
    
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
    
    @Published
    var emoji: String = ""
    
    init() {
        self.$emoji
            .sink(receiveCompletion: { err in
               print("CHEGA", err)
            }, receiveValue: { newValue in
                print("RECVD", newValue)
            })
            .store(in: &cancelBag)
    }
    
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
        eventSender.send(title: title,
                         emoji: emoji,
                         isAllDay: isAllDay,
                         startDate: startDate,
                         endDate: endDate)
    
    }
}

enum RepeatingFrequency: String, CaseIterable {
    case never = "Nunca"
    case daily = "Todo dia"
    case weekly = "Toda semana"
    case everyTwoWeeks = "A cada duas semanas"
    case monthly = "Todo mês"
}
