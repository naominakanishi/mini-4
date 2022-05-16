import Foundation
import Academy

final class RequestForHelpViewModel: ObservableObject {
    
    @Published var helpRepository = HelpRepository()
    @Published var categoryChosen: HelpType? = nil
    @Published var subject: String = ""
    @Published var description: String = ""
    @Published var location: String = ""
    
    func createNewHelp() {
        let newHelpRequest = Help(id: UUID().uuidString, title: subject, description: description, type: categoryChosen ?? .all, currentLocation: location, requestTimeInterval: Date().timeIntervalSince1970, assignee: nil)
        
        helpRepository.create(newHelpRequest)
    }
}
