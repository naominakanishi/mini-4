import SwiftUI
import Academy
import AcademyUI

final class ContentViewModel: ObservableObject {
    @Published
    private(set) var assignments: [AssignmentListView.Model] = []
    
    let filterAssignment = FilterAssignment()
    
    func onAppear() {
        assignments = filterAssignment
            .filter(byType: .design)
            .map { .init(fromDomain: $0) }
    }
}

struct ContentView: View {
    @StateObject
    private var viewModel = ContentViewModel()
    
    var body: some View {
        List {
            AssignmentListView(assignments: viewModel.assignments)
        }
        .onAppear(perform: viewModel.onAppear)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension AssignmentListView.Model {
    init(fromDomain model: Assignment) {
        let firstLetter = model.assignee.name.first ?? .init("")
        self.init(assigneeName: String(firstLetter))
    }
}
