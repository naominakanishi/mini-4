import Academy
import Combine
import AcademyUI

final class TVMainScreenViewModel: ObservableObject {
    
    @Published
    private(set) var announcementList: [Announcement] = []
    
    @Published
    private(set) var activeAnnouncements: [Announcement] = []
    
    @Published
    var userImageUrl: URL?
    
    @Published
    var userRole: Role = .student
    
    @Published
    var todayEvents: MonthModel = .init(name: "Home", days: [])
    
    private var cancellabels: Set<AnyCancellable> = []
    
    private let announcementListenerService: AnnouncementListenerService
    private let eventListenerService: CalendarEventListenerService
    
    init(announcementListenerService: AnnouncementListenerService = .init(),
         eventListenerService: CalendarEventListenerService = .init()
    ) {
        self.announcementListenerService = announcementListenerService
        self.eventListenerService = eventListenerService
    
        bindToRepository()
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
