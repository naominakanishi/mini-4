import SwiftUI
import Academy
import Combine

final class AnnouncementListViewModel: ObservableObject {
    
    @Published private (set) var announcementList: [Announcement] = []
    
    @Published
    var announcementOnEdit: Announcement? = nil
    
    @Published
    var user: AcademyUser = .init(id: "", name: "", email: "", imageName: "", status: nil, birthday: nil, role: nil, helpTags: nil)
    
    private let listener: AnnouncementListenerService
    private let userListener = UserListenerService()
    
    init(listener: AnnouncementListenerService) {
        self.listener = listener
        self.listen()
    }
    
    func listen() {
        userListener
            .listener
            .assign(to: &$user)
        
        listener
            .listen()
            .assign(to: &$announcementList)
    }
}
