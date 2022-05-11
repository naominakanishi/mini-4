//
//  ContentView.swift
//  AcademyTV
//
//  Created by Naomi Nakanishi on 10/05/22.
//

import SwiftUI
import Academy
import AcademyUI

final class ContentViewModel: ObservableObject {
    @Published
    private(set) var progsAssignments: [AssignmentListView.Model] = []
    @Published
    private(set) var designAssignments: [AssignmentListView.Model] = []
    @Published
    private(set) var businessAssignments: [AssignmentListView.Model] = []
    
    let filterAssignment = FilterAssignment()
    
    func onAppear() {
        progsAssignments = filterAssignment
            .filter(byType: .progs)
            .map { .init(fromDomain: $0) }
        designAssignments = filterAssignment
            .filter(byType: .design)
            .map { .init(fromDomain: $0) }
        businessAssignments = filterAssignment
            .filter(byType: .business)
            .map { .init(fromDomain: $0) }
    }
}

struct ContentView: View {
    
    @StateObject
    private var viewModel = ContentViewModel()
    
    var body: some View {
        HStack {
            AssignmentListView(assignments: viewModel.progsAssignments)
            AssignmentListView(assignments: viewModel.designAssignments)
            AssignmentListView(assignments: viewModel.businessAssignments)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension AssignmentListView.Model {
    init(fromDomain model: Assignment) {
        self.init(assigneeName: model.assignee.name)
    }
}
