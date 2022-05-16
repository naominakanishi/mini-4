import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

public final class AnnouncementRepository: ObservableObject {
    
    private let path = "announcement"
    private let store = Firestore.firestore()
    @Published public var announcementList: [Announcement] = []
    
    public init() {
        read()
    }
    
    public func create(_ announcement: Announcement) {
        do {
            _ = try store.collection(path).addDocument(from: announcement)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read() {
        store.collection(path).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            self.announcementList = snapshot?.documents.compactMap {
                do {
                    return try $0.data(as: Announcement.self)
                } catch {
                    print(error.localizedDescription)
                    return nil
                }
            } ?? []
            
            self.sortAnnouncementList()
        }
    }
    
    func update(_ help: Help) {
        // To do
    }
    
    func delete(_ helpId: String) {
        // To do
    }
    
    private func sortAnnouncementList() {
        self.announcementList = self.announcementList.sorted { announcementA, announcementB in
            announcementA.createdTimeInterval < announcementB.createdTimeInterval
        }
    }
}
