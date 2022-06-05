import Foundation
import Academy

final class ContentViewModel: ObservableObject {
    @Published private(set) var announcementList: [Announcement] = []
    
    let announcementFilter = AnnouncementListenerService()
    
    func onAppear() {
        announcementFilter
            .activeAnnouncements
            .assign(to: &$announcementList)
    }
}
