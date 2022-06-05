import Foundation
import Combine

final class AnnouncementRepository: ObservableObject {
    
    static let shared = AnnouncementRepository()
    
    private let path = "announcement"
    private var store: FirestoreRef {
        FirebaseProxy.shared.firestore()
    }
    
    let readingPublisher = CurrentValueSubject<Data, Never>(.emptyJson)
    
    init() {
        read()
    }
    
    func create(announcementData data: [String: Any], id: String) -> AnyPublisher<Bool, Error> {
        let response = PassthroughSubject<Bool, Error>()
        store.collection(path: path).document(id: id).setData(data: data) {
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
        store.collection(path: path).addSnapshotListener (callback: { (snapshot, error) in
            if let error = error {
                print("FAILED!", error.localizedDescription)
                return
            }
            
            // Review
            guard let dictionaries = snapshot else {
                return
            }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: dictionaries, options: [])
                self.readingPublisher.send(data)
            } catch {
                print("DEU RUM!", error)
            }
        })
    }
    
    func update(_ announcement: Announcement) -> AnyPublisher<Bool, Error> {
        let response = PassthroughSubject<Bool, Error>()
        do {
            try store.collection(path: path).document(id: announcement.id).setData(using: announcement) {
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
