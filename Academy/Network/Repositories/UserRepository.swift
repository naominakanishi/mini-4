import Foundation
import Combine

final class UserRepository: ObservableObject {
    
    static let shared = UserRepository()
    
    private let path = "user"
    private var store: FirestoreRef {
        FirebaseProxy.shared.firestore()
    }
    
    private var storage: StorageRef {
        StorageProxy.shared.storage()
    }
    
    let currentUserPublisher = CurrentValueSubject<Data, Never>(.init())
    let allUsersPublisher = CurrentValueSubject<Data, Error>(.init())
    
    init() {
        startListeningForUsers()
    }
    
    func initializeUser(withId id: String) {
        store.collection(path: path).document(id: id).addSnapshotListener(callback: { (document, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let dictionary = document,
                  let data = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
            else {
                print("User doesn't exist")
                return
            }
            print("SENDING UP")
            self.currentUserPublisher.send(data)
        })
    }
    
    private func startListeningForUsers(){
        store.collection(path: path).addSnapshotListener(callback: { snapshot, error in
            if let error = error {
                self.allUsersPublisher.send(completion: .failure(error))
                return
            }
            guard let dictionaries = snapshot?.compactMap { $0 },
                  let data = try? JSONSerialization.data(withJSONObject: dictionaries, options: [])
            else { return }
            self.allUsersPublisher.send(data)
        })
    }
    
    func checkIfUserExists(with id: String) -> Future<[String: Any]?, Error> {
        Future<[String: Any]?, Error> { promise in
            self.store.collection(path: self.path).document(id: id).getDocument(source: .server, completion: { document, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }

                guard let data = document else {
                    print("User doesn't exist")
                    promise(.success(nil))
                    return
                }
                promise(.success(data))
            })
        }
    }
    
    func createUser(userData data: [String: Any], with id: String) -> Future<Void, Error> {
        Future<Void, Error> { promise in
            self.store.collection(path: self.path).document(id: id).setData(data: data) {
                if let error = $0 {
                    promise(.failure(error))
                    return
                }
                promise(.success(()))
            }
        }
    }
    
    func update(_ user: AcademyUser) -> AnyPublisher<AcademyUser, Error> {
        let response = PassthroughSubject<AcademyUser, Error>()
        do {
            let dictionary = try user.toFirebase()
            store.collection(path: path).document(id: user.id).setData(data: dictionary) {
                if let error = $0 {
                    response.send(completion: .failure(error))
                    return
                }
                response.send(user)
//                self.publisher.send(encoded)
            }
        } catch {
            response.send(completion: .failure(error))
        }
        return response
            .eraseToAnyPublisher()
    }
    
    func updateImage(using data: Data, usingFileName fileName: String) -> AnyPublisher<URL, Error> {
        let publisher = PassthroughSubject<URL, Error>()
        let ref = storage.child(path: "user_images").child(path: fileName + ".png")

        ref.putData(data) { _, error in
            if let error = error {
                publisher.send(completion: .failure(error))
                return
            }

            ref.downloadURL { result in
                switch result {
                case let .success(url):
                    publisher.send(url)
                case let .failure(error):
                    publisher.send(completion: .failure(error))
                    
                }
            }
        }
        return publisher
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
