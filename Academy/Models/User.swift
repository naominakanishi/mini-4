import Foundation

public struct User: ExpressibleByStringLiteral, Hashable {
    let id = UUID()
    public let name: String
    let token: String
    
    public init(stringLiteral value: StringLiteralType) {
        name = value
        token = "dummy"
    }
}

