import SwiftUI
import AuthenticationServices
import FirebaseAuth

struct SignInWithAppleView: UIViewRepresentable {
    @ObservedObject var loginViewModel: LoginViewModel
    
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIButton {
        let button = UIButton(type: .custom)
        
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .large
        configuration.baseForegroundColor = UIColor(.adaBackground)
        configuration.image = UIImage(systemName: "applelogo")
        configuration.baseBackgroundColor = UIColor(.white)
        configuration.imagePadding = 16
        configuration.titlePadding = 8
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32)
        
        var attText = AttributedString.init("Sign in with Apple")
        attText.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        attText.foregroundColor = UIColor(.adaBackground)
        
        configuration.attributedTitle = attText
        
        button.configuration = configuration
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
        button.addTarget(context.coordinator, action: #selector(Coordinator.login), for: .touchDown)
        return button
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    class Coordinator: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
        let parent: SignInWithAppleView?
        
        init(parent: SignInWithAppleView) {
            self.parent = parent
            super.init()
        }
        
        @objc func login() {
            let request = parent!.loginViewModel.getLoginRequest()
            
            let authController = ASAuthorizationController(authorizationRequests: [request])
            authController.presentationContextProvider = self
            authController.delegate = self
            authController.performRequests()
        }
        
        func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
            // Review
            let vc = UIApplication.shared.windows.last?.rootViewController
            return (vc?.view.window!)!
        }
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            guard let _ = parent else {
                fatalError("No parent found")
            }
            
            if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
                parent?.loginViewModel.signIn(appleIdCredential: credential)
            }
        }
    }
}
