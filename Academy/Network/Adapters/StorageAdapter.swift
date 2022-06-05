import Foundation

public protocol StorageRef {
    func child(path: String) -> StorageRef
    func putData(_ data: Data, completion: @escaping (Any?, Error?) -> Void)
    func downloadURL(completion: @escaping (Result<URL, Error>) -> Void)
}

public final class StorageProxy {
    private var instance: StorageRef?
    
    static let shared = StorageProxy()
    public static func configure(using adapter: StorageRef) {
        shared.instance = adapter
    }
    
    func storage() -> StorageRef {
        instance!
    }
}
