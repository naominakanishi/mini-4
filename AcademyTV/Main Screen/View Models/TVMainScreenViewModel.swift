import Academy
import AcademyUI
import SwiftUI
import Combine

final class TVMainScreenViewModel: ObservableObject {
    
    @Published
    private(set) var activeAnnouncements: [Announcement] = []
    
    @Published
    private(set) var currentPresentedAnnouncementId: String?
    
    @Published
    private(set) var currentMomentEvents: [String] = []
    
    @Published
    private(set) var todayEvents: MonthModel?
    
    private let announcementListenerService: AnnouncementListenerService
    private let eventListenerService: CalendarEventListenerService
    
    init(announcementListenerService: AnnouncementListenerService = .init(),
         eventListenerService: CalendarEventListenerService = .init()
    ) {
        self.announcementListenerService = announcementListenerService
        self.eventListenerService = eventListenerService
        bindToRepository()
    }
    
    private func bindToRepository() {
        configureAnnouncementsScroll()
        
        announcementListenerService
            .activeAnnouncements
            .assign(to: &$activeAnnouncements)
        
        eventListenerService
            .todayEvents
            .map { events in
                events
                    .filter { $0.fullDay }
                    .map { $0.title }
            }
            .assign(to: &$currentMomentEvents)
        
        eventListenerService
            .todayEvents
            .map { events in
                events.filter { !$0.fullDay }
            }
            .filter {
                !$0.isEmpty
            }
            .map {
                MonthModel(name: "Eventos do dia", from: $0)
            }
            .assign(to: &$todayEvents)
    }
    
    private func configureAnnouncementsScroll() {
        let timer = Timer.publish(
            every: 1,
            on: .main,
            in: .common
        ).autoconnect()
        
        Publishers.CombineLatest($activeAnnouncements, timer)
            .scan((0, [Announcement]())) { ($0.0 + 1, $1.0) }
            .map {
                let announcements = $0.1
                let currentIndex = $0.0 % announcements.count
                return announcements[currentIndex].id
            }
            .prefix(10)
            .assign(to: &$currentPresentedAnnouncementId)
    }
}
