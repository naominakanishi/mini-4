import Foundation

public extension Data {
    static var emptyJson: Self {
        try! JSONEncoder().encode([String]())
    }
}

public extension URL {
    init?(_ string: String?) {
        guard let string = string
        else { return nil }
        self.init(string: string)
    }
}
