import Foundation
import Academy
import Combine

final class CalendarEventListViewModel: ObservableObject {
    
    private let listenerService = CalendarEventListenerService()
    
    private var cancellable: AnyCancellable?
    
    @Published var calendarEventList: [CalendarEvent] = []
    
    @Published var calendarDaysList: [CalendarDay] = []
    
    func handleOnAppear() {
        cancellable?.cancel()
        cancellable = listenerService
            .listen()
            .replaceError(with: [])
            .assign(to: \.calendarEventList, on: self)
    }
}

