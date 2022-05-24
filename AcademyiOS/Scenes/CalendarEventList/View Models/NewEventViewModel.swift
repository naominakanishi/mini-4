import SwiftUI
import Academy
import Combine

final class NewEventViewModel: ObservableObject {
    
    private let eventSender = CalendarEventSenderService()
    
    var cancelBag = [AnyCancellable]()
    
    @Published
    var title: String = ""
    
    @Published
    var isAllDay = false
    
    @Published
    var startDate: Date = .now
    
    @Published
    var endDate: Date = .now
    
    @Published
    var repeatingFrequency: String? =  RepeatingFrequency.never.rawValue
    
    @Published
    var emoji: String = ""
    
    @Published
    private(set) var showsRepeatingFrequency: Bool = true
    
    init() {
        self.$emoji
            .sink(receiveCompletion: { err in
               print("CHEGA", err)
            }, receiveValue: { newValue in
                print("RECVD", newValue)
            })
            .store(in: &cancelBag)
        
        Publishers.CombineLatest($startDate, $endDate)
            .map { (startDate, endDate) in
                startDate.distance(to: endDate) < TimeConstants.secondsInADay &&
                startDate.distance(to: endDate) >= 0
            }
            .assign(to: &$showsRepeatingFrequency)
    }
    
    var availableDateComponents: DatePickerComponents {
        if isAllDay {
            return [.date]
        }
        return [
            .date,
            .hourAndMinute,
        ]
    }

    var frequencyOptions: [String] {
        RepeatingFrequency.allCases.map { $0.rawValue }
    }
    
    func send() -> AnyPublisher<Void, Error> {
        let frequency: RepeatingFrequency
        if let repeatingFrequency = repeatingFrequency, showsRepeatingFrequency {
            guard let index = frequencyOptions.firstIndex(of: repeatingFrequency)
            else {
                return Fail(outputType: Void.self, failure: NSError(domain: "AcademyPocket", code: -4213, userInfo: nil))
                    .eraseToAnyPublisher()
            }
            frequency = RepeatingFrequency.allCases[index]
        } else {
            frequency = .never
        }
        return eventSender.send(title: title,
                         emoji: emoji,
                         isAllDay: isAllDay,
                         startDate: startDate,
                         endDate: endDate,
                         repeats: frequency
        )
    }
}
