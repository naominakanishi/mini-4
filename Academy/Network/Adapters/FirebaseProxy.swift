public final class FirebaseProxy {
    private var instance: FirestoreRef?
    
    static let shared = FirebaseProxy()
    
    public static func configure(using adapter: FirestoreRef) {
        shared.instance = adapter
    }
    
    func firestore() -> FirestoreRef {
        guard let instance = instance else {
            fatalError("Trying to access firestore before configuring it! Be sure to call `configure` using a valid firestore implementation")
        }
        return instance
    }
}
