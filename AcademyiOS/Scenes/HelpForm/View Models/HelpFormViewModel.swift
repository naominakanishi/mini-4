import Foundation
import Academy

final class HelpFormViewModel: ObservableObject {
    
    private var helpModel: Help? = nil
    private var user: AcademyUser
    private let helpSenderService = HelpSenderService()
    private let helpUpdatingService = HelpUpdatingService()
    
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var currentLocation: String = ""
    @Published var type: HelpType? = nil
    
    var buttonText: String {
        if helpModel != nil {
            return "Salvar edição"
        } else {
            return "Pedir ajuda"
        }
    }
    
    init(helpModel: Help?, user: AcademyUser) {
        self.user = user
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
                user: user,
                title: title,
                description: description,
                type: type ?? .all,
                currentLocation: currentLocation,
                requestTimeInterval: helpModel!.requestTimeInterval,
                assignee: nil,
                status: helpModel!.status
            )
            updateHelp(updatedHelp)
        } else {
            createNewHelp()
        }
    }
    
    private func createNewHelp() {
        let newHelpRequest = Help(id: UUID().uuidString, user: user, title: title, description: description, type: type ?? .all, currentLocation: currentLocation, requestTimeInterval: Date().timeIntervalSince1970, assignee: nil, status: .waitingForHelp)
        
        helpSenderService.send(help: newHelpRequest)
    }
    
    private func updateHelp(_ help: Help) {
        helpUpdatingService.execute(using: help)
    }
}
