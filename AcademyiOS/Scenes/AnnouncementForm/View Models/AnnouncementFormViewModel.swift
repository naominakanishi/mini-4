import Academy
import Combine

class AnnouncementFormViewModel: ObservableObject {
    @Published
    var content: String = ""
    
    @Published
    var headline: String = ""
    
    var isButtonDisabled: Bool {
        return content.isEmpty ||
            headline.isEmpty
    }
    
    private var cancelBag: [AnyCancellable] = []
    
    private let sender: AnnouncementSenderService
    
    private let currentUser: AcademyUser
    
    init(currentUser: AcademyUser, sender: AnnouncementSenderService) {
        self.currentUser = currentUser
        self.sender = sender
    }
    
    func handleSend() {
        sender.send(content: content, user: currentUser)
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
}
