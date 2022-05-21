import Foundation
import Academy
import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {
    
    @Published private(set) var announcementList: [Announcement] = []
    
    @Published private(set) var activeAnnouncements: [Announcement] = []
    
    private var cancellabels: Set<AnyCancellable> = []
    
    private let announcementUpdatingService: AnnouncementUpdatingService
    private let announcementListenerService: AnnouncementListenerService
    private let openLearningJourneyService: LJRoutingService
    
    init(announcementUpdatingService: AnnouncementUpdatingService,
         announcementListenerService: AnnouncementListenerService,
         openLearningJourneyService: LJRoutingService = .init()
    ) {
        self.announcementUpdatingService = announcementUpdatingService
        self.announcementListenerService = announcementListenerService
        self.openLearningJourneyService = openLearningJourneyService
        
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
    }
}
