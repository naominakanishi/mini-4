import Foundation
import Academy
import Combine
import SwiftUI
import AcademyUI

final class CalendarEventListViewModel: ObservableObject {
    
    private let listenerService = CalendarEventListenerService()
    
    @Published
    private(set) var calendar: [MonthModel] = []
    
    
    func handleOnAppear() {
        listenerService
            .listen()
            .map { self.getMonths(forDomainEvents: $0) }
            .assign(to: &$calendar)
    }
    
    private func getMonths(forDomainEvents events: [CalendarEvent]) -> [MonthModel] {
        events.groups(by: { $0.startDate.month }, sorting: { dict in
            dict.values.sorted {
                $0[0].startDate < $1[0].startDate
            }
        })
            .map { events in
            let month = events[0].startDate.month
            return MonthModel(name: month, from: events)
        }
    }
}
