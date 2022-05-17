import Academy
import Combine

class AnnouncementFormViewModel: ObservableObject {
    @Published
    var content: String = ""
    var isButtonDisabled: Bool {
        return content.isEmpty == true
    }
    private var cancelBag: [AnyCancellable] = []
    
    private let sender: AnnouncementSenderService
    
    init(sender: AnnouncementSenderService) {
        self.sender = sender
    }
    
    func handleSend() {
        sender.send(content: content)
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
