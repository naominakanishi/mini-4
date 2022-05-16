import Foundation
import Academy
import Combine

final class HomeViewModel: ObservableObject {
    @Published var announcementRepository = AnnouncementRepository()
    @Published var announcementList: [Announcement] = []
    
    private var cancellabels: Set<AnyCancellable> = []
    
    init() {
        readAnnouncementList()
    }
    
    func readAnnouncementList() {
        announcementRepository.$announcementList
            .assign(to: \.announcementList, on: self)
            .store(in: &cancellabels)
        
        print(announcementList)
    }
    
    func createAnnouncement() {
        // To do
    }
}
