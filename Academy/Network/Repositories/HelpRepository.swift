import Foundation
import Combine

final class HelpRepository: ObservableObject {
    
    static let shared = HelpRepository()
    
    private let path = "help"
    private var store: FirestoreRef {
        FirebaseProxy.shared.firestore()
    }
    
    let readingPublisher = CurrentValueSubject<Data, Never>(.emptyJson)
    
    init() {
        self.read()
    }
    
    func create(helpData data: [String: Any], id: String) -> AnyPublisher<Bool, Error> {
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
    
    func update(_ help: Help) -> AnyPublisher<Bool, Error> {
        let response = PassthroughSubject<Bool, Error>()
        do {
            try store.collection(path: path).document(id: help.id)
                .setData(using: help) {
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
    
    private func read() {
        store.collection(path: path).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print("FAILED!", error.localizedDescription)
            }

            guard let dictionaries = snapshot else { fatalError() }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: dictionaries, options: [])
                self.readingPublisher.send(data)
            } catch {
                print("DEU RUM!", error)
            }
        }
    }
    
    func delete(_ help: Help) {
        // To do
    }
}
