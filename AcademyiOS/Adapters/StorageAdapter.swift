import FirebaseStorage
import Academy
import Foundation

extension StorageReference: StorageRef {
    public func child(path: String) -> StorageRef {
        child(path)
    }
    
    public func putData(_ data: Data, completion: @escaping (Any?, Error?) -> Void) {
        self.putData(data, metadata: nil) {
            completion($0, $1)
        }
    }
}
