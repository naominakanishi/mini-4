import Foundation
import Academy
import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {
    
    @Published private(set) var announcementList: [Announcement] = []
    @Published private(set) var activeAnnouncements: [Announcement] = []
    
    @Published
    var userImageUrl: URL?
    
    private var cancellabels: Set<AnyCancellable> = []
    
    private let announcementUpdatingService: AnnouncementUpdatingService
    private let announcementListenerService: AnnouncementListenerService
    private let openLearningJourneyService: LJRoutingService
    private let userListenerService: UserListenerService
    
    init(announcementUpdatingService: AnnouncementUpdatingService = .init(),
         announcementListenerService: AnnouncementListenerService = .init(),
         openLearningJourneyService: LJRoutingService = .init(),
         userListenerService: UserListenerService = .init()
    ) {
        self.announcementUpdatingService = announcementUpdatingService
        self.announcementListenerService = announcementListenerService
        self.openLearningJourneyService = openLearningJourneyService
        self.userListenerService = userListenerService
        
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
            .map {
                URL(string: $0)
            }
            .assign(to: &$userImageUrl)
    }
}
