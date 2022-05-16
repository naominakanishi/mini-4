import Foundation
import Academy
import Combine
import SwiftUI

final class HelpListViewModel: ObservableObject {
    
    @Published var helpRepository = HelpRepository()
    @Published var helpList: [Help] = []
    @Published var currentHelpList: [Help] = []
    
    @Published var filterChosen: HelpType = .all {
        didSet {
            selectFilter(helpType: filterChosen)
        }
    }
    
    @Published var showRequestHelpModal: Bool = false
    
    private var cancellabels: Set<AnyCancellable> = []
    
    init() {
        readHelpList()
    }
    
    func readHelpList() {
        helpRepository.$helpList
            .assign(to: \.helpList, on: self)
            .store(in: &cancellabels)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.currentHelpList = self.helpList
            self.selectFilter(helpType: self.filterChosen)
        }
    }
    
    func selectFilter(helpType: HelpType) {
        if helpType == .all {
            currentHelpList = helpList
        } else {
            currentHelpList = helpList.filter({ help in
                help.type == helpType
            })
        }
    }
}
