import Foundation

public struct AnnouncementFilter {
    let http: HTTP
    
    public init() {
        self.init(http: HTTP())
    }
    
    internal init(http: HTTP) {
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
