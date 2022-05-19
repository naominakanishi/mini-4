import Foundation

extension Encodable {
    func toFirebase() throws -> [String: Any] {
        let data: Data = try JSONEncoder().encode(self)
        guard let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        else {
            throw FirebaseDecodingError.invalidType
        }
        return dict
    }
}

enum FirebaseDecodingError: Error {
    case invalidType
}
