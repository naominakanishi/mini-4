import AuthenticationServices
import CryptoKit
import FirebaseAuth

public final class AuthService {
    
    private var currentNonce: String?
    
    public init() {}
    
    public func getLoginRequest() -> ASAuthorizationAppleIDRequest {
        let provider = ASAuthorizationAppleIDProvider()
        currentNonce = randomNonceString()
        
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        return request
    }
    
    public func signIn(with appleIdCredential: ASAuthorizationAppleIDCredential) {
        guard let nonce = currentNonce else {
            fatalError("Invalid state: A login callback was received, but no login request was sent.")
        }
        guard let appleIDToken = appleIdCredential.identityToken else {
            print("Unable to fecth identity token")
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
                
                // Review
                let viewController = UIApplication.shared.windows.first!.rootViewController!
                viewController.present(alertVC, animated: true, completion: nil)
                
                print(error.localizedDescription)
            case .success(_):
                print("Signed in with Apple id")
            }
        }
    }
    
    private func auth(using credential: AuthCredential, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(with: credential, completion: { (_, err) in
            if let error = err {
                completionHandler(.failure(error))
                return
            }
            
            if let authUser = Auth.auth().currentUser {
                print("Auth user:", authUser)
                completionHandler(.success(true))
            }
        })
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
