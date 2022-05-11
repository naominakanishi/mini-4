import Foundation
import Academy

final class ContentViewModel: ObservableObject {
    @Published private(set) var progsHelpList: [Help] = []
    @Published private(set) var designHelpList: [Help] = []
    @Published private(set) var businessHelpList: [Help] = []
    
    let filterAssignment = FilterAssignment()
    
    func onAppear() {
        progsHelpList = filterAssignment.filter(byType: .code)
        designHelpList = filterAssignment.filter(byType: .design)
        businessHelpList = filterAssignment.filter(byType: .business)
    }
}
