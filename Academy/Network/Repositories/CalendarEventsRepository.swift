import Foundation
import Combine

final class CalendarEventsRepository: ObservableObject {
    
    static let shared = CalendarEventsRepository()
    
    private let path = "events"
    private var store: FirestoreRef {
        FirebaseProxy.shared.firestore()
    }
    
    let readingPublisher = CurrentValueSubject<Data, Never>(.emptyJson)
    
    init() {
        read()
    }
    
    func create(eventData data: [String: Any], id: String) -> AnyPublisher<Bool, Error> {
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
    
    func createBatch(eventData data: [[String: Any]]) -> Future<Void, Error> {
        .init { [store, path] promise in
            let batch = store.createBatch()
            let collectionReferece = store.collection(path: path)
            
            data.forEach {
                let ref = collectionReferece.document(id: $0["id"] as! String)
                batch.setData($0, documentRef: ref)
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
        store.collection(path: path).addSnapshotListener(callback: { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        
            guard let dictionaries = snapshot else {
                fatalError()
            }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: dictionaries, options: [])
                self.readingPublisher.send(data)
            } catch {
                print("DEU RUM!", error)
            }
        })
    }
    
    func update(_ event: CalendarEvent) -> AnyPublisher<Bool, Error> {
        let response = PassthroughSubject<Bool, Error>()
        do {
            try store.collection(path: path).document(id: event.id)
                .setData(using: event) {
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

