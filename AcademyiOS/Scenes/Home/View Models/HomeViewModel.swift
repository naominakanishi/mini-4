import Foundation
import Academy
import Combine
import SwiftUI
import AcademyUI

final class HomeViewModel: ObservableObject {
    
    @Published private(set) var announcementList: [Announcement] = []
    @Published private(set) var activeAnnouncements: [Announcement] = []
    
    @Published
    var userImageUrl: URL?
    
    @Published
    private(set) var todayEvents: MonthModel = .init(name: "Home", days: [])
    
    private var cancellabels: Set<AnyCancellable> = []
    
    private let announcementUpdatingService: AnnouncementUpdatingService
    private let announcementListenerService: AnnouncementListenerService
    private let openLearningJourneyService: LJRoutingService
    private let userListenerService: UserListenerService
    private let eventListenerService: CalendarEventListenerService
    
    init(announcementUpdatingService: AnnouncementUpdatingService = .init(),
         announcementListenerService: AnnouncementListenerService = .init(),
         openLearningJourneyService: LJRoutingService = .init(),
         userListenerService: UserListenerService = .init(),
         eventListenerService: CalendarEventListenerService = .init()
    ) {
        self.announcementUpdatingService = announcementUpdatingService
        self.announcementListenerService = announcementListenerService
        self.openLearningJourneyService = openLearningJourneyService
        self.userListenerService = userListenerService
        self.eventListenerService = eventListenerService
        
        bindToRepository()
    }
    
    func openLearningJourney() {
        openLearningJourneyService.route()
    }
    
    private func bindToRepository() {
        announcementListenerService
            .listen()
            .assign(to: &$announcementList)
        announcementListenerService
            .activeAnnouncements
            .assign(to: &$activeAnnouncements)
        
        userListenerService
            .listener
            .map { $0.imageName }
            .map { URL(string: $0) }
            .assign(to: &$userImageUrl)
        
        eventListenerService
            .todayEvents
            .map { events in
                let month = MonthModel(name: "Hoje", from: events)
                dump(month)
                return month
            }
            .assign(to: &$todayEvents)
    }
}
