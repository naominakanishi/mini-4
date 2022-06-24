import SwiftUI
import Academy
import AcademyUI
import FirebaseFirestore
import FirebaseStorage
import Firebase

@main
struct AcademyiPadApp: App {
    
    init() {
        FirebaseApp.configure()
        
        let app = FirebaseApp.app()!
        let firestore = Firestore.firestore(app: app)
        let storage =  Storage.storage()
        
        let settings = firestore.settings
        settings.isPersistenceEnabled = false
        firestore.settings = settings
        
        FirebaseProxy.configure(using: firestore)
        StorageProxy.configure(using: storage.reference())
    }
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
        }
    }
}
