public enum AuthChange {
    
}

public protocol AuthCredential {}

public protocol User {
    var uid: String { get }
    var displayName: String? { get }
    var email: String? { get }
}

public protocol Auth {
    var activeUser: User? { get }
    func addStateDidChangeListener(_ listener: @escaping (Auth, User?) -> Void)
    func signIn(with credential: AuthCredential, completion: @escaping (Any?, Error?) -> Void)
    func signOut() throws
}



typealias AuthStateDidChangeListenerHandle = Void

public final class AuthProxy {
    private var authInstance: Auth?
    private var _authProvider: OAuthProvider?
    
    static let shared = AuthProxy()
    
    public typealias OAuthProvider = (String, String, String) -> AuthCredential
    
    public static func configure(auth: Auth, authProvider: @escaping OAuthProvider) {
        shared.authInstance = auth
        shared._authProvider = authProvider
    }
    
    func auth() -> Auth {
        authInstance!
    }
    
    func authProvider() -> OAuthProvider {
        _authProvider!
    }
}
