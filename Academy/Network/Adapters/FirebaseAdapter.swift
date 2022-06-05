import Foundation

public protocol FirestoreRef {
    func collection(path: String) -> FirebaseCollectionReferenceProtocol
    func createBatch() -> FirebaseBatchProtocol
}

public protocol FirebaseCollectionReferenceProtocol {
    func document(id: String) -> FirebaseDocumentReferenceProtocol
    func addSnapshotListener(callback: @escaping ([[String:Any]]?, Error?) -> Void)
    func addDocument(using data: [String: Any], completion: @escaping (Error?) -> Void)
}

public protocol FirebaseDocumentReferenceProtocol {
    func setData(data: [String: Any], completion: @escaping (Error?) -> Void)
    func setData<T>(using object: T, completion: @escaping (Error?) -> Void) throws where T: Encodable
    func addSnapshotListener(callback: @escaping ([String: Any]?, Error?) -> Void)
    func getDocument(source: FirebaseSource, completion: @escaping ([String: Any]?, Error?) -> Void)
}

public protocol FirebaseBatchProtocol {
    func setData(_ data: [String: Any], documentRef: FirebaseDocumentReferenceProtocol)
    func commit(_ completion: @escaping (Error?) -> Void)
}

public enum FirebaseSource {
    case server
}

