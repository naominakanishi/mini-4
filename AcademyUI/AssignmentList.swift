import SwiftUI

public struct AssignmentListView: View {
    public struct Model: Identifiable {
        public let id: UUID = .init()
        let assigneeName: String
        
        public init(assigneeName: String) {
            self.assigneeName = assigneeName
        }
    }
    
    let assignments: [Model]
    
    public init(assignments: [Model]) {
        self.assignments = assignments
    }
    
    public var body: some View {
        List {
            ForEach(assignments) {
                Text($0.assigneeName)
            }
        }
    }
}
