import SwiftUI
import FirebaseCore
import CryptoKit
import Academy

@main
struct AcademyiOSApp: App {
    @UIApplicationDelegateAdaptor private var delegate: AppDelegate
    @StateObject var authService = AuthService()
    
    var body: some Scene {
        WindowGroup {
            LoadingView()
                .environmentObject(authService)
                .preferredColorScheme(.dark)
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
      [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Configure Firebase
        FirebaseApp.configure()
        
        return true
    }
}
