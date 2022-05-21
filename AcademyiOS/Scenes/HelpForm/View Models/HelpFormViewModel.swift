import Foundation
import Academy
import Combine
import SwiftUI
import AcademyUI

final class HelpFormViewModel: ObservableObject {
    
    private var helpModel: Help? = nil
    private var user: AcademyUser
    private let helpSenderService = HelpSenderService()
    private let helpUpdatingService = HelpUpdatingService()
    private var cancelBag: [AnyCancellable] = []
    
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var currentLocation: String = ""
    @Published var type: HelpType? = nil
    
    
    @Published
    var tags: [AcademyTagModel] = []
    
    var isButtonDisabled: Bool {
        title.isEmpty ||
        description.isEmpty ||
        currentLocation.isEmpty
    }
    
    private var selectedTagIndex = 0
    private let availableTags = HelpType.allCases.filter { $0 != .all }
    
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
        renderTags()
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
    
    func didSelectTag(withId id: UUID) {
        guard let index = tags.firstIndex(where: { $0.id == id })
        else { return }
        selectedTagIndex = index
        renderTags()
    }
    
    private func renderTags() {
        tags = availableTags.enumerated().map {
            .init(name: $1.rawValue,
                  color: $1.color,
                  isSelected: $0 == selectedTagIndex)
        }
    }
    
    private func createNewHelp() {
        let type = availableTags[selectedTagIndex]
        let newHelpRequest = Help(id: UUID().uuidString,
                                  user: user,
                                  title: title,
                                  description: description,
                                  type: type,
                                  currentLocation: currentLocation,
                                  requestTimeInterval: Date().timeIntervalSince1970,
                                  assignee: nil,
                                  status: .waitingForHelp
        )
        
        helpSenderService.send(help: newHelpRequest)
            .sink(receiveCompletion: { error in
                // TODO display error
            }, receiveValue: {
                if !$0 {
                    // TODO display error
                    return
                }
                
                // TODO display success
            })
            .store(in: &cancelBag)
    }
    
    private func updateHelp(_ help: Help) {
        helpUpdatingService.execute(using: help)
    }
}
