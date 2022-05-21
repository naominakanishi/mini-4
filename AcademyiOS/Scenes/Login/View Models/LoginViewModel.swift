import Foundation
import Academy
import AuthenticationServices

final class LoginViewModel: ObservableObject {
    private let authService = AuthService()
    
    func getLoginRequest() -> ASAuthorizationAppleIDRequest {
        authService.getLoginRequest()
    }
    
    func signIn(appleIdCredential: ASAuthorizationAppleIDCredential) {
        authService.signIn(with: appleIdCredential)
    }
}
