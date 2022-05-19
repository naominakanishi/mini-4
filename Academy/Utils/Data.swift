public extension Data {
    static var emptyJson: Self {
        try! JSONEncoder().encode([String]())
    }
}
