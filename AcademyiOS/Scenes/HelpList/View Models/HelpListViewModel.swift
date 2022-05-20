import Foundation
import Academy
import Combine
import SwiftUI

final class HelpListViewModel: ObservableObject {
    struct FilterTag: Identifiable {
        let id = UUID()
        let name: String
        let color: Color
        let isSelected: Bool
    }
    
    private var user: AcademyUser
    private let listener: HelpListenerService
    private let helpUpdatingService: HelpUpdatingService
    private let helpAssignService: HelpAssignService
    
    private var cancelable: AnyCancellable?
    
    @Published var showRequestHelpModal: Bool = false
    
    @Published var helpOnEdit: Help? = nil
    
    @Published var currentHelpList: [Help] = []
    
    @Published
    private(set) var filterTags: [FilterTag] = []
    
    private var selectedFilterIndex = 0
    
    init(currentUser: AcademyUser, listener: HelpListenerService, helpAssignService: HelpAssignService, helpUpdatingService: HelpUpdatingService) {
        self.user = currentUser
        self.listener = listener
        self.helpAssignService = helpAssignService
        self.helpUpdatingService = helpUpdatingService
    }
    
    func handleOnAppear() {
        updateFilters()
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
    
    func didSelectFilter(withId id: UUID) {
        guard let index = filterTags.firstIndex(where: { $0.id == id})
        else { return }
        selectedFilterIndex = index
        updateFilters()
    }
    
    private func updateFilters() {
        filterTags = HelpType.allCases.enumerated().map {
            .init(name: $1.rawValue,
                  color: $1.color,
                  isSelected: $0 == selectedFilterIndex
            )
        }
        renderFilteredList()
    }
    
    
    private func renderFilteredList() {
        let helpType = HelpType.allCases[selectedFilterIndex]
        cancelable?.cancel()
        cancelable = listener
            .listen(to: helpType)
            .assign(to: \.currentHelpList, on: self)
    }
}
