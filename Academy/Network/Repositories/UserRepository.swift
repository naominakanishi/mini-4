import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
//import CodableFirebase
import FirebaseStorage

final class UserRepository: ObservableObject {
    
    static let shared = UserRepository()
    
    private let path = "user"
    private let store = Firestore.firestore()
    private let storage = Storage.storage()
    
    let currentUserPublisher = CurrentValueSubject<Data, Never>(.init())
    let allUsersPublisher = CurrentValueSubject<Data, Error>(.init())
    
    init() {
        startListeningForUsers()
    }
    
    func initializeUser(withId id: String) {
        store.collection(path).document(id).addSnapshotListener { (document, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let document = document,
                  let dictionary = document.data(),
                  let data = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
            else {
                print("User doesn't exist")
                return
            }
            print("SENDING UP")
            self.currentUserPublisher.send(data)
        }
    }
    
    private func startListeningForUsers(){
        store.collection(path).addSnapshotListener { snapshot, error in
            if let error = error {
                self.allUsersPublisher.send(completion: .failure(error))
                return
            }
            guard let documents = snapshot?.documents else { return }
            let dictionaries = documents.compactMap { snapshot in
                snapshot.data()
            }
            guard let data = try?JSONSerialization.data(withJSONObject: dictionaries, options: []) else { return }
            self.allUsersPublisher.send(data)
        }
    }
    
    func checkIfUserExists(with id: String) -> Future<[String: Any]?, Error> {
        Future<[String: Any]?, Error> { promise in
            self.store.collection(self.path).document(id).getDocument(source: .server, completion: { document, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                
                guard let data = document?.data() else {
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
            self.store.collection(self.path).document(id).setData(data) {
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
            store.collection(path).document(user.id).setData(dictionary) {
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
        let ref = storage.reference().child("user_images").child(fileName + ".png")

        ref.putData(data, metadata: nil) { _, error in
            if let error = error {
                publisher.send(completion: .failure(error))
                return
            }
            
            ref.downloadURL { url, error in
                if let error = error {
                    publisher.send(completion: .failure(error))
                    return
                }
                
                if let url = url {
                    publisher.send(url)
                    return
                }
                publisher.send(completion: .finished)
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
