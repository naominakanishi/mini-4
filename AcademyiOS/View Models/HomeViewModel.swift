import Foundation
import Academy
import Combine

final class HomeViewModel: ObservableObject {
    @Published var announcementRepository = AnnouncementRepository()
    @Published var announcementList: [Announcement] = []
    @Published var activeAnnouncements: [Announcement] = []
    
    private var cancellabels: Set<AnyCancellable> = []
    
    init() {
        readAnnouncementList()
    }
    
    func readAnnouncementList() {
        announcementRepository.$announcementList
            .assign(to: \.announcementList, on: self)
            .store(in: &cancellabels)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.activeAnnouncements = self.announcementList.filter({ announcement in
                announcement.isActive == true
            })
        }
    }
    
    func createAnnouncement() {
        // To do
    }
}
