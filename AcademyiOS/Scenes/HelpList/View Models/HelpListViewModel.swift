import Foundation
import Academy
import Combine
import SwiftUI

final class HelpListViewModel: ObservableObject {
    struct HelpModel: Identifiable {
        let id = UUID()
        let isOwner: Bool
        let queuePosition: Int
        let help: Help
    }
    
    struct FilterTag: Identifiable {
        let id = UUID()
        let name: String
        let color: Color
        let isSelected: Bool
    }
    
    private let listener: HelpListenerService
    private let helpUpdatingService: HelpUpdatingService
    private let helpAssignService: HelpAssignService
    private let userLisenterService: UserListenerService = .init()
    
    @Published var showRequestHelpModal: Bool = false
    
    @Published var helpOnEdit: Help? = nil
    
    @Published var currentHelpList: [HelpModel] = []
    
    @Published
    private(set) var filterTags: [FilterTag] = []
    
    private var selectedFilterIndex = 0
    
    private var disposeBag = [AnyCancellable]()
    
    init(listener: HelpListenerService, helpAssignService: HelpAssignService, helpUpdatingService: HelpUpdatingService) {
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
        userLisenterService
            .listener
            .flatMap { user in
                self.helpAssignService.assign(using: help, currentUser: user)
            }
            .replaceError(with: false)
            .sink { _ in
                self.renderFilteredList()
            }
            .store(in: &disposeBag)
    }
    
    func completeHelpHandler(help: Help) {
        var helpUpdated = help
        helpUpdated.status = .done
        helpUpdatingService.execute(using: helpUpdated)
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
        Publishers.CombineLatest(userLisenterService.listener, listener.listen(to: helpType))
            .map { user, helpList in
                helpList.map { help in
                    HelpModel(isOwner: user.id == help.user.id,
                              queuePosition: self.getQueuePosition(help: help, onList: helpList),
                              help: help)
                }
            }
            .assign(to: &$currentHelpList)
    }
    
    func getQueuePosition(help: Help, onList currentHelpList: [Help]) -> Int {
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
