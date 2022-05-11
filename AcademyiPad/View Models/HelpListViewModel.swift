import Foundation
import Academy

final class HelpListViewModel: ObservableObject {
    @Published var codeHelpList: [Help] = []
    @Published var designHelpList: [Help] = []
    @Published var businessHelpList: [Help] = []
    
    let helpFilter = HelpFilter()
    
    func onAppear() {
        codeHelpList = helpFilter.filter(byType: .code)
        designHelpList = helpFilter.filter(byType: .design)
        businessHelpList = helpFilter.filter(byType: .business)
    }
}
