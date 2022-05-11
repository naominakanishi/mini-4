import Foundation
import Academy

final class ContentViewModel: ObservableObject {
    @Published private(set) var announcementList: [Announcement] = []
    
    let announcementFilter = AnnouncementFilter()
    
    func onAppear() {
        announcementList = announcementFilter.filterActiveAnnouncements()
    }
}
