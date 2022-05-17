import Foundation
import Academy
import Combine
import SwiftUI

final class HelpListViewModel: ObservableObject {
    
    private let listener: HelpListenerService
    private let helpUpdatingService: HelpUpdatingService
    private let helpAssignService: HelpAssignService
    
    private var cancelable: AnyCancellable?
    
    @Published var helpOnEdit: Help? = nil
    
    @Published var currentHelpList: [Help] = []
    
    @Published var filterChosen: HelpType = .all {
        didSet {
            selectFilter(helpType: filterChosen)
        }
    }
    
    @Published var showRequestHelpModal: Bool = false
    
    
    init(listener: HelpListenerService, helpAssignService: HelpAssignService, helpUpdatingService: HelpUpdatingService) {
        self.listener = listener
        self.helpAssignService = helpAssignService
        self.helpUpdatingService = helpUpdatingService
    }
    
    func selectFilter(helpType: HelpType) {
        cancelable?.cancel()
        cancelable = listener
            .listen(to: helpType)
            .mapError({ error -> Error in
                print("ERROR", error)
                return error
            })
            .replaceError(with: [])
            .assign(to: \.currentHelpList, on: self)
    }
    
    func handleOnAppear() {
        selectFilter(helpType: .all)
    }
    
    func handleCardLongPress(helpModel: Help) {
        showRequestHelpModal = true
        helpOnEdit = helpModel
    }
    
    func assignHelpHandler(help: Help) {
        helpAssignService.assign(using: help)
    }
    
    func completeHelpHandler(help: Help) {
        var helpUpdated = help
        helpUpdated.status = .done
        helpUpdatingService.execute(using: helpUpdated)
    }
}
