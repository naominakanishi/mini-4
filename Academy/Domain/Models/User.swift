import Foundation

public struct User: Hashable, Codable {
    var id = UUID()
    public let name: String
    public let imageName: String
    let token: String
    
    public init(name: String, imageName: String) {
        self.name = name
        self.token = "dummy"
        self.imageName = imageName
    }
}

