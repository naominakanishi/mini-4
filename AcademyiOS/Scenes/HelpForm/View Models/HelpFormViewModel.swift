import Foundation
import Academy

final class HelpFormViewModel: ObservableObject {
    
    private let helpSenderService = HelpSenderService()
    private let helpUpdatingService = HelpUpdatingService()
    
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var currentLocation: String = ""
    @Published var type: HelpType? = nil
    
    var helpModel: Help? = nil
    
    init(helpModel: Help?) {
        self.helpModel = helpModel
        self.title = helpModel?.title ?? ""
        self.description = helpModel?.description ?? ""
        self.currentLocation = helpModel?.currentLocation ?? ""
        self.type = helpModel?.type ?? .all
    }
    
    func tapButtonHandle() {
        if helpModel != nil {
            let updatedHelp = Help(
                id: helpModel!.id,
                title: title,
                description: description,
                type: type ?? .all,
                currentLocation: currentLocation,
                requestTimeInterval: helpModel!.requestTimeInterval,
                assignee: nil
            )
            updateHelp(updatedHelp)
        } else {
            createNewHelp()
        }
    }
    
    private func createNewHelp() {
        let newHelpRequest = Help(id: UUID().uuidString, title: title, description: description, type: type ?? .all, currentLocation: currentLocation, requestTimeInterval: Date().timeIntervalSince1970, assignee: nil)
        
        helpSenderService.send(help: newHelpRequest)
    }
    
    private func updateHelp(_ help: Help) {
        helpUpdatingService.execute(using: help).sink { error in
            print("Teste")
        } receiveValue: { success in
            if success {
                print("Deu boa")
            }
        }

    }
}
