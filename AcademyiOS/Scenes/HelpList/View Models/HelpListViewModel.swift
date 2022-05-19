import Foundation
import Academy
import Combine
import SwiftUI

final class HelpListViewModel: ObservableObject {
    
    private var user: AcademyUser
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
    
    
    init(currentUser: AcademyUser, listener: HelpListenerService, helpAssignService: HelpAssignService, helpUpdatingService: HelpUpdatingService) {
        self.user = currentUser
        self.listener = listener
        self.helpAssignService = helpAssignService
        self.helpUpdatingService = helpUpdatingService
    }
    
    func selectFilter(helpType: HelpType) {
        cancelable?.cancel()
        cancelable = listener
            .listen(to: helpType)
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
        helpAssignService.assign(using: help, currentUser: user)
    }
    
    func completeHelpHandler(help: Help) {
        var helpUpdated = help
        helpUpdated.status = .done
        helpUpdatingService.execute(using: helpUpdated)
    }
    
    func getQueuePosition(help: Help) -> Int {
        let typeList = currentHelpList.filter { h in
            h.type == help.type
        }
        let sortedTypeList = typeList.sorted { h1, h2 in
            h1.requestDate < h2.requestDate
        }
        let index = sortedTypeList.firstIndex { h in
            h.id == help.id
        }
        return (index ?? 999) + 1
    }
}
