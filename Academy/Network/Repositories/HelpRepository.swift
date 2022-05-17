import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

public final class HelpRepository: ObservableObject {
    
    private let path = "help"
    private let store = Firestore.firestore()
    
    @Published public var helpList: [Help] = []
    
    public let readingPublisher = CurrentValueSubject<Data, Never>(.emptyJson)
    static let shared = HelpRepository()
    
    public init() {
        self.initialize()
    }
    
    public func create(helpData data: [String: Any], id: String) -> AnyPublisher<Bool, Error> {
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
 
    
    func update(_ help: Help) -> AnyPublisher<Bool, Error> {
        let response = PassthroughSubject<Bool, Error>()
        do {
            try store.collection(path).document(help.id)
                .setData(from: help) {
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
    
    func delete(_ help: Help) {
        // To do
    }
    
    private func initialize() {
        store.collection(path).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print("FAILED!", error.localizedDescription)
            }
            // Review
            guard let snapshot = snapshot else { fatalError() }
            
            let dictionaries: [[String : Any]] = snapshot.documents.map { $0.data() }
            dump(dictionaries)
            let data = try! JSONSerialization.data(withJSONObject: dictionaries, options: [])
            self.readingPublisher.send(data)
        }
    }
}

extension Data {
    static var emptyJson: Self {
        try! JSONEncoder().encode([String]())
    }
}
