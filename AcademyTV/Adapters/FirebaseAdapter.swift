import FirebaseFirestore
import FirebaseFirestoreSwift
import Academy

extension WriteBatch: FirebaseBatchProtocol {
    public func setData(_ data: [String : Any], documentRef: FirebaseDocumentReferenceProtocol) {
        self.setData(data, forDocument: documentRef as! DocumentReference) // TODO forced casting!
    }
    
    public func commit(_ completion: @escaping (Error?) -> Void) {
        self.commit(completion: completion)
    }
}

extension Firestore: FirestoreRef {
    public func createBatch() -> FirebaseBatchProtocol {
        self.batch()
    }
    
    public func collection(path: String) -> FirebaseCollectionReferenceProtocol {
        collection(path)
    }
}

extension CollectionReference: FirebaseCollectionReferenceProtocol {
    public func addDocument(using data: [String : Any], completion: @escaping (Error?) -> Void) {
        addDocument(data: data, completion: completion)
    }
    
    public func document(id: String) -> FirebaseDocumentReferenceProtocol {
        document(id)
    }
    
    public func addSnapshotListener(callback: @escaping ([[String: Any]]?, Error?) -> Void) {
        addSnapshotListener({ snapshot, error in
            let data: [[String : Any]]? = snapshot?.documents.map { $0.data() }
            callback(data, error)
        })
    }
}

extension DocumentReference: FirebaseDocumentReferenceProtocol {
    public func getDocument(source: FirebaseSource, completion: @escaping ([String : Any]?, Error?) -> Void) {
        getDocument(source: source.toFirebase()) { snap, error in
            completion(snap?.data(), error)
        }
    }
    
    public func setData<T>(using object: T, completion: @escaping (Error?) -> Void) throws where T : Encodable {
        try setData(from: object, encoder: .init(), completion: completion)
    }
    
    public func setData(data: [String: Any], completion: @escaping (Error?) -> Void) {
        setData(data, completion: completion)
    }
    
    public func addSnapshotListener(callback: @escaping ([String: Any]?, Error?) -> Void) {
        addSnapshotListener({ (snap: DocumentSnapshot?, error: Error?) in
            snap?.data()
            callback(snap?.data(), error)
        })
    }
}

extension FirebaseSource {
    func toFirebase() -> FirestoreSource {
        switch self {
        case .server:
            return .server
        }
    }
}
