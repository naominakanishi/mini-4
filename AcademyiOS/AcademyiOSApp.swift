import SwiftUI
import FirebaseCore
import CryptoKit
import Academy
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

@main
struct AcademyiOSApp: App {
    @UIApplicationDelegateAdaptor private var delegate: AppDelegate
    init() {
        FirebaseApp.configure()
        
        FirebaseProxy.configure(using: Firestore.firestore())
        StorageProxy.configure(using: Storage.storage().reference())
        AuthProxy.configure(auth: FirebaseAuth.Auth.auth()) {
            OAuthProvider.credential(withProviderID: $0, idToken: $1, rawNonce: $2)
        }
        
        let settings = Firestore.firestore().settings
        settings.isPersistenceEnabled = false
        Firestore.firestore().settings = settings
        
    }
    var body: some Scene {
        WindowGroup {
            LoadingView()
                .preferredColorScheme(.dark)
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
      [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Configure Firebase
        
        
        return true
    }
}
