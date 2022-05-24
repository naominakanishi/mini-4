import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class CalendarEventsRepository: ObservableObject {
    
    static let shared = CalendarEventsRepository()
    
    private let path = "events"
    private let store = Firestore.firestore()
    
    let readingPublisher = CurrentValueSubject<Data, Never>(.emptyJson)
    
    init() {
        read()
    }
    
    func create(eventData data: [String: Any], id: String) -> AnyPublisher<Bool, Error> {
        let response = PassthroughSubject<Bool, Error>()
        store.collection(path).document(id).setData(data) {
            if let _ = $0 {
                response.send(false)
                return
            }
            response.send(true)
        }
        return response
            .eraseToAnyPublisher()
    }
    
    func createBatch(eventData data: [[String: Any]]) -> Future<Void, Error> {
        .init { [store, path] promise in
            let batch = store.batch()
            let collectionReferece = store.collection(path)
            
            data.forEach {
                let ref = collectionReferece.document($0["id"] as! String)
                batch.setData($0, forDocument: ref)
            }
            
            batch.commit { error in
                if let error = error {
                    promise(.failure(error))
                }
                promise(.success(()))
            }
        }
    }
    
    private func read() {
        store.collection(path).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        
            guard let snapshot = snapshot else {
                fatalError()
            }
            
            let dictionaries: [[String: Any]] = snapshot.documents.map { $0.data() }
            do {
                let data = try JSONSerialization.data(withJSONObject: dictionaries, options: [])
                self.readingPublisher.send(data)
            } catch {
                print("DEU RUM!", error)
            }
        }
    }
    
    func update(_ event: CalendarEvent) -> AnyPublisher<Bool, Error> {
        let response = PassthroughSubject<Bool, Error>()
        do {
            try store.collection(path).document(event.id)
                .setData(from: event) {
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
}

