import SwiftUI
import Academy
import Combine

final class AnnouncementListViewModel: ObservableObject {
    
    struct AnnouncementModel: Identifiable {
        let id = UUID()
        let isOwner: Bool
        let announcement: Announcement
    }
    
    @Published private (set) var announcementList: [AnnouncementModel] = []
    
    private let listener: AnnouncementListenerService
    private let userListener = UserListenerService()
    
    init(listener: AnnouncementListenerService) {
        self.listener = listener
        Publishers.CombineLatest(userListener.listener, listener.listen())
            .map { user, announcements in
                announcements
                    .prefix(4)
                    .map { announcement in
                        AnnouncementModel(isOwner: user.id == announcement.fromUser.id,
                                          announcement: announcement)
                    }
            }
            .assign(to: &$announcementList)
    }
}
