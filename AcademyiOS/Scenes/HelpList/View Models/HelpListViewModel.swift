import Foundation
import Academy
import Combine
import SwiftUI

final class HelpListViewModel: ObservableObject {
    
    private let listener: HelpListenerService
    private var cancelable: AnyCancellable?
    
    @Published var helpOnEdit: Help? = nil
    
    @Published var currentHelpList: [Help] = []
    
    @Published var filterChosen: HelpType = .all {
        didSet {
            selectFilter(helpType: filterChosen)
        }
    }
    
    @Published var showRequestHelpModal: Bool = false
    
    
    init(listener: HelpListenerService) {
        self.listener = listener
    }
    
    func selectFilter(helpType: HelpType) {
        cancelable?.cancel()
        cancelable = listener
            .listen(to: helpType)
            .mapError({ error -> Error in
                print("ERRROR", error)
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
}
