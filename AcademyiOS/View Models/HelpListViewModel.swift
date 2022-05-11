import Foundation
import Academy

final class HelpListViewModel: ObservableObject {
    
    @Published private(set) var helpList: [Help] = []
    @Published var showRequestHelpModal: Bool = false
    @Published var currentHelpModelList: [Help] = []
    @Published var filterChosen: HelpType = .all {
        didSet {
            selectFilter(helpType: filterChosen)
        }
    }
    
    let helpFilter = HelpFilter()
        
    func onAppear() {
        currentHelpModelList = helpFilter.fetchHelpList()
    }
    
    func selectFilter(helpType: HelpType) {
        currentHelpModelList = helpFilter.filter(byType: helpType)
    }
}
