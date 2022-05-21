//
//  ProfilePictureViewModel.swift
//  AcademyiOS
//
//  Created by HANNA P C FERREIRA on 17/05/22.
//

import Foundation
import AcademyUI
import Academy

final class ProfileViewModel: ObservableObject {
    
    @Published
    var displayName: String = "" // TODO feed proper username
    
    @Published
    private(set) var helpTags: [AcademyTagModel] = []
    
    @Published
    var birthday: Date = .now
    
    var availableRoles: [String] {
        Role.allCases
            .filter { $0 != .all }
            .map {
            $0.rawValue
        }
    }
    
    @Published
    var currentRole: String?
    
    init() {
        
        renderHelpTags()
    }
    
    private func renderHelpTags() {
        helpTags = HelpType.allCases.map {
            .init(name: $0.rawValue, color: $0.color, isSelected: false) // TODO is selected
        }
    }
}
