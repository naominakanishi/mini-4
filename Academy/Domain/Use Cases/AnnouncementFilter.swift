import Foundation

public struct AnnouncementFilter {
    let http: FirebaseService
    
    public init() {
        self.init(http: FirebaseService())
    }
    
    internal init(http: FirebaseService) {
        self.http = http
    }
    
    public func fetchAnnouncementList() -> [Announcement] {
        http.fetchAnnouncementList()
    }
    
    public func filterActiveAnnouncements() -> [Announcement] {
        return http.fetchAnnouncementList().filter { announcement in
            announcement.isActive == true
        }
    }
}
