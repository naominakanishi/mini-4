import Foundation
import Academy

class RequestForHelpViewModel: ObservableObject {
    
    let firebaseService = FirebaseService()
    
    @Published var categoryChosen: HelpType? = nil
    @Published var subject: String = ""
    @Published var description: String = ""
    @Published var location: String = ""
    
    func sendHelpRequest() {
        let newHelpRequest = Help(title: subject, description: description, type: categoryChosen ?? .all, currentLocation: location, requestTimeInterval: Date().timeIntervalSince1970, assignee: nil)
        
        firebaseService.createNewHelpRequest(help: newHelpRequest) {
            print("Realmente deu certo")
        }
    }
    
}
