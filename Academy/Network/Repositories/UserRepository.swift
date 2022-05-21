import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
import CodableFirebase

final class UserRepository: ObservableObject {
    
    static let shared = UserRepository()
    
    private let path = "user"
    private let store = Firestore.firestore()
    
    init() {}
    
    func checkIfUserExists(with id: String) -> AnyPublisher<Bool, Never> {
        let publisher = PassthroughSubject<Bool, Never>()
        
        store.collection(path).document(id).getDocument(source: .server, completion: { document, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let data = document?.data() else {
                print("User doesn't exist")
                publisher.send(false)
                return
            }
            
            publisher.send(true)
        })
        
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchUser(with id: String) -> AnyPublisher<Data, Never> {
        let publisher = PassthroughSubject<Data, Never>()
        
        store.collection(path).document(id).addSnapshotListener { (document, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let document = document else {
                print("User doesn't exist")
                return
            }
            
            let dictionary: [String: Any] = document.data()!
            
            let data = try! JSONSerialization.data(withJSONObject: dictionary, options: [])
            
            publisher.send(data)
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func createUser(userData data: [String: Any], with id: String) -> AnyPublisher<Bool, Error> {
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
    
    func update(_ user: AcademyUser) -> AnyPublisher<Bool, Error> {
        let response = PassthroughSubject<Bool, Error>()
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .millisecondsSince1970
            let encoded = try encoder.encode(user)
            guard let dictionary = try JSONSerialization.jsonObject(with: encoded) as? [String: Any]
            else {
                fatalError()
            }
            dump(dictionary)
            store.collection(path).document(user.id).setData(dictionary) {
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

extension JSONDecoder {
    static var firebaseDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return decoder
    }
}
