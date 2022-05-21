import AuthenticationServices
import CryptoKit
import FirebaseAuth
import Combine

public final class AuthService: ObservableObject {
    
    private let userListenerService = UserListenerService()
    private let userSenderService = UserSenderService()
    private let userExistenceCheckerService = UserExistenceCheckerService()
    
    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    private let userRepository: UserRepository
    
    private var currentNonce: String?
    
    private var cancellabels: [AnyCancellable] = []
    
    @Published public var authState: AuthState = .undefined {
        didSet {
            print("New auth state:", authState)
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                print("User:", self.user)
            }
        }
    }
    
    @Published public var user: AcademyUser = .init(
        id: "ERRO",
        name: "",
        email: "",
        imageName: "",
        status: nil,
        birthday: nil,
        role: nil,
        helpTags: []
    )
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
        self.initialize()
    }
    
    public convenience init() {
        self.init(userRepository: .shared)
    }
    
    public func initialize() {
        self.authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ change, user in
            if let authUser = Auth.auth().currentUser {
                // Create user if needed
                self.userExistenceCheckerService.userExists(id: authUser.uid).sink { userExists in
                    if userExists {
                        self.userListenerService.listenUser(with: authUser.uid)
                            .assign(to: &self.$user)
                    } else {
                        self.userSenderService
                            .send(user: AcademyUser(
                                id: authUser.uid,
                                name: authUser.displayName ?? "",
                                email: authUser.email!,
                                imageName: "",
                                status: .available,
                                birthday: nil,
                                role: nil,
                                helpTags: []
                            ))
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.authState = .signedIn
                    }
                }.store(in: &self.cancellabels)
            } else {
                self.signOut { error in
                    if error != nil {
                        print("Logout")
                        self.authState = .signedOut
                    }
                }
            }
        })
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
        
        let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)

        self.auth(using: credential) { result in
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
            }
        }
    }
    
    private func auth(using credential: AuthCredential, completionHandler: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(with: credential, completion: { (_, err) in
            if let error = err {
                completionHandler(.failure(error))
                return
            }
            
            if let authUser = Auth.auth().currentUser {
                completionHandler(.success(authUser))
            }
        })
    }
    
    public func signOut(completion: @escaping (Result<Bool, Error>) -> Void) {
        let auth = Auth.auth()
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
