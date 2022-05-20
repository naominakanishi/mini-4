import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class AnnouncementRepository: ObservableObject {
    
    static let shared = AnnouncementRepository()
    
    private let path = "announcement"
    private let store = Firestore.firestore()
    
    let readingPublisher = CurrentValueSubject<Data, Never>(.emptyJson)
    
    init() {
        read()
    }
    
    func create(announcementData data: [String: Any]) -> AnyPublisher<Bool, Error> {
        let response = PassthroughSubject<Bool, Error>()
        store.collection(path).addDocument(data: data) {
            if let _ = $0 {
                response.send(false)
                return
            }
            response.send(true)
        }
        return response
            .eraseToAnyPublisher()
    }
    
    private func read() {
        store.collection(path).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print("FAILED!", error.localizedDescription)
            }
            
            // Review
            guard let snapshot = snapshot else { fatalError()
            }
            
            let dictionaries: [[String: Any]] = snapshot.documents.map { $0.data() }
            let data = try! JSONSerialization.data(withJSONObject: dictionaries, options: [])
            
            self.readingPublisher.send(data)
        }
    }
    
    func update(_ announcement: Announcement) -> AnyPublisher<Bool, Error> {
        let response = PassthroughSubject<Bool, Error>()
        do {
            try store.collection(path).document(announcement.id).setData(from: announcement) {
                if let error = $0 {
                    response.send(false)
                    return
                }
                
                response.send(true)
            }
        } catch {
            return Fail(outputType: Bool.self, failure: error)
                .eraseToAnyPublisher()
        }
        return response
            .eraseToAnyPublisher()
    }
    
    func delete(_ helpId: String) {
        // To do
    }
}
