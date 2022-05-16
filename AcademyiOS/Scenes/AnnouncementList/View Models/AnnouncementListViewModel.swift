import SwiftUI
import Academy

class AnnouncementListViewModel: ObservableObject {
   @Published
    private (set) var announcements: [Announcement] = []
    
    private let listener: AnnouncementListenerService
    
    init(listener: AnnouncementListenerService) {
        self.listener = listener
        listener.listen().assign(to: &$announcements)
    }
}
