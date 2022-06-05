import AuthenticationServices
import CryptoKit
import Combine
// https://github.com/google/GoogleSignIn-iOS.git

public final class AuthService {
    
    private let userListenerService = UserListenerService()
    private let userSenderService = UserSenderService()
    private let userRepository: UserRepository = .shared
    
    private var currentNonce: String?
    private var cancellabels: [AnyCancellable] = []
    
    public var authStatePublisher: CurrentValueSubject<AuthState, Never> = .init(.undefined)
    private var authStateDidChangeListenerHandle: Any?
    
    public static let shared = AuthService()
    
    private var auth: Auth {
        AuthProxy.shared.auth()
    }
    
    private init(userRepository: UserRepository) {
        initialize()
    }
    
    private convenience init() {
        self.init(userRepository: .shared)
    }
    
    private func initialize() {
        self.authStateDidChangeListenerHandle = auth.addStateDidChangeListener({ [weak self] change, user in
            guard let self = self
            else { return }
            
            guard let user = self.auth.activeUser
            else {
                self.signOut { error in
                    if error != nil {
                        print("Logout")
                        self.authStatePublisher.send(.signedOut)
                    }
                }
                return
            }
            
            self.userRepository
                .checkIfUserExists(with: user.uid)
                .tryMap { existingUser in
                    if let existingUser = existingUser {
                        return existingUser
                    }
                    return try self.createNewUser(user: user)
                }
                .flatMap { dictionary -> AnyPublisher<Void, Error> in
                    self.userRepository
                        .createUser(userData: dictionary, with: user.uid)
                        .eraseToAnyPublisher()
                }
                .flatMap { _ in Just(AuthState.signedIn(user.uid)) }
                .replaceError(with: .signedOut)
                .sink {
                    self.authStatePublisher.send($0)
                }
                .store(in: &self.cancellabels)
        })
        
        authStatePublisher
            .sink { state in
                switch state {
                case let .signedIn(userId):
                    self.userRepository.initializeUser(withId: userId)
                case .signedOut, .undefined:
                    // TODO sign out from repository
                    break
                }
            }
            .store(in: &cancellabels)
    }
    
    private func createNewUser(user: User) throws -> [String: Any] {
        let user = AcademyUser(
            id: user.uid,
            name: user.displayName ?? "",
            email: user.email ?? "",
            imageName: "invalid_image",
            status: .available,
            birthday: Date.now.timeIntervalSince1970,
            role: .student,
            helpTags: []
        )
        return try user.toFirebase()
    }
    
    public func signIn(with appleIdCredential: ASAuthorizationAppleIDCredential) {
        guard let nonce = currentNonce else {
            fatalError("Invalid state: A login callback was received, but no login request was sent.")
        }
        guard let appleIDToken = appleIdCredential.identityToken else {
            print("Unable to fetch identity token")
            return
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
            return
        }
        
        let credential = AuthProxy.shared.authProvider()("apple.com", idTokenString, nonce)
        
        self.authenticate(using: credential) { result in
            switch result {
            case .failure(let error):
                let alertVC = UIAlertController(title: "Ops!", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alertVC.addAction(okAction)
                
                let viewController = UIApplication.shared.windows.first!.rootViewController!
                viewController.present(alertVC, animated: true, completion: nil)
                
                print(error.localizedDescription)
            case .success(let authUser):
                print("Signed in with Apple id")
                self.authStatePublisher.send(.signedIn(authUser.uid))
            }
        }
    }
    
    private func authenticate(using credential: AuthCredential, completionHandler: @escaping (Result<User, Error>) -> Void) {
        auth.signIn(with: credential, completion: { [weak self] (_, err) in
            if let error = err {
                completionHandler(.failure(error))
                return
            }
            
            if let authUser = self?.auth.activeUser {
                completionHandler(.success(authUser))
            }
        })
    }
    
    public func signOut(completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            try auth.signOut()
            completion(.success(true))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    public func getLoginRequest() -> ASAuthorizationAppleIDRequest {
        let provider = ASAuthorizationAppleIDProvider()
        currentNonce = randomNonceString()
        
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        return request
    }
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    func hashed(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}
