import Academy
import Combine
import SwiftUI
import AcademyUI

class AnnouncementFormViewModel: ObservableObject {
    struct TypeTag: Identifiable {
        let id = UUID()
        let text: String
        let color: Color
        let isSelected: Bool
    }
    @Published
    var content: String = ""
    
    @Published
    var headline: String = ""
    
    @Published
    var announcementTypes: [TypeTag] = []
    
    
    private var selectedTypeIndex = 0
    
    var isButtonDisabled: Bool {
        content.isEmpty ||
        headline.isEmpty
    }
    
    private var cancelBag: [AnyCancellable] = []
    
    private let sender: AnnouncementSenderService
    private let userListenerService = UserListenerService()
    
    init(sender: AnnouncementSenderService) {
        self.sender = sender
        
        updateAnnouncementTypes()
    }
    
    func handleSend() {
        userListenerService
            .listener
            .flatMap { [self] user in
                sender.send(content: self.content, user: user, type: AnnouncementType.allCases[self.selectedTypeIndex])
            }
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
    
    func handleSelect(announcementId id: UUID) {
        guard let index = announcementTypes.firstIndex(where: { $0.id == id })
        else { return }
        selectedTypeIndex = index
        updateAnnouncementTypes()
    }
    
    private func updateAnnouncementTypes() {
        
        announcementTypes = AnnouncementType.allCases.enumerated().map {
            let color: Color
            switch $1 {
            case .announcement:
                color = .blue // TODO change to proper color
            case .assignment:
                color = .red  // TODO change to proper color
            }
            return .init(text: $1.rawValue,
                         color: color,
                         isSelected: $0 == selectedTypeIndex)
        }
    }
}
