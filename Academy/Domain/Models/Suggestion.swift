import Foundation

public struct Suggestion: Codable {
    public var id: String
    public var text: String
    public var createdDateString: String
             
    public init(id: String, text: String, createdDateString: String) {
        self.id = id
        self.text = text
        self.createdDateString = createdDateString
    }
}
