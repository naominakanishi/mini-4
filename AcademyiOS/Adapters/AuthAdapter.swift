import FirebaseAuth
import Academy

extension FirebaseAuth.Auth: Academy.Auth {
    public var activeUser: Academy.User? {
        self.currentUser
    }
    
    public func addStateDidChangeListener(_ listener: @escaping (Academy.Auth, Academy.User?) -> Void) -> Any? {
        self.addStateDidChangeListener { (auth: FirebaseAuth.Auth, user: FirebaseAuth.User?) in
            listener(auth, user)
        }
    }
    
    public func signIn(with credential: Academy.AuthCredential, completion: @escaping (Any?, Error?) -> Void) {
        self.signIn(with: credential as! FirebaseAuth.AuthCredential) { (authDataResult: AuthDataResult?, error: Error?) in
            completion(authDataResult, error)
        }
    }
}

extension FirebaseAuth.User: Academy.User {}

extension FirebaseAuth.AuthCredential: Academy.AuthCredential {}
