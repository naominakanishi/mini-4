import SwiftUI
import FirebaseCore
import CryptoKit
import Academy
import FirebaseFirestore

@main
struct AcademyiOSApp: App {
    @UIApplicationDelegateAdaptor private var delegate: AppDelegate
    init() {
        FirebaseApp.configure()
        
        let settings = Firestore.firestore().settings
        settings.isPersistenceEnabled = false
        Firestore.firestore().settings = settings
        
    }
    var body: some Scene {
        WindowGroup {
            TVMainScreenView()
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
