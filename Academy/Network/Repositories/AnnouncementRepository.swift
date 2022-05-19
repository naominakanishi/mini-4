import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

public final class AnnouncementRepository: ObservableObject {
    
    static let shared = AnnouncementRepository()
    
    private let path = "announcement"
    private let store = Firestore.firestore()
    
    public init() {}
    
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
    
    public func read() -> AnyPublisher<Data, Never> {
        let publisher = PassthroughSubject<Data, Never>()
        
        store.collection(path).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            // Review
            guard let snapshot = snapshot else { fatalError()
            }
            
            let dictionaries: [[String: Any]] = snapshot.documents.map { $0.data() }
            let data = try! JSONSerialization.data(withJSONObject: dictionaries, options: [])
            
            publisher.send(data)
        }
        
        return publisher.eraseToAnyPublisher()
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
