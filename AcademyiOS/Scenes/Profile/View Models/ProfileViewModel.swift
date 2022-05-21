//
//  ProfilePictureViewModel.swift
//  AcademyiOS
//
//  Created by HANNA P C FERREIRA on 17/05/22.
//

import Foundation
import AcademyUI
import Academy
import Combine
import UIKit

final class ProfileViewModel: ObservableObject {
    
    @Published
    var displayName: String = "" // TODO feed proper username
    @Published
    private(set) var helpTags: [AcademyTagModel] = []
    @Published
    var birthday: Date = .now
    @Published
    var currentRole: String?
    @Published
    var imageSelected: UIImage?
    
    var availableRoles: [String] {
        Role.allCases
            .filter { $0 != .all }
            .map {
            $0.rawValue
        }
    }
    
    private let userListenerService: UserListenerService
    private let userUpdatingService: UserUpdatingService
    
    private var currentUserHelpTags: [HelpType] = []
    private var currentUser: AcademyUser?
    private var cancelBag: [AnyCancellable] = []
    
    init(currentUserId: String) {
        userListenerService = .init()
        userUpdatingService = .init()
        
        renderHelpTags()
        
        userListenerService
            .listenUser(with: currentUserId)
            .sink { user in
                self.currentUser = user
                
                if let birthday = user.birthday {
                    self.birthday = birthday
                }
                
                self.currentUserHelpTags = user.helpTags ?? []
                self.displayName = user.name
                self.currentRole = user.role?.rawValue ?? Role.student.rawValue
                self.renderHelpTags()
            }
            .store(in: &cancelBag)
    }
    
    func save() {
        guard let currentUser = currentUser else {
            return
        }
        let role = Role.allCases.first(where: { $0.rawValue == currentRole }) ?? .student
        
        _ = userUpdatingService.update(with: .init(
            id: currentUser.id,
            name: displayName,
            email: currentUser.imageName,
            imageName: currentUser.imageName,
            status: currentUser.status,
            birthday: birthday ,
            role: role,
            helpTags: currentUserHelpTags
        ))
    }
    
    func onTagSelected(tagId id: UUID) {
        guard let selectedTagName = helpTags.first(where: { $0.id  == id })?.name,
              let tag = HelpType.allCases.first(where: { $0.rawValue == selectedTagName })
        else { return }
        
        defer { renderHelpTags() }
        
        if currentUserHelpTags.contains(tag) {
            currentUserHelpTags.removeAll(where: { $0 == tag })
            return
        }
        currentUserHelpTags.append(tag)
    }
    
    private func renderHelpTags() {
        helpTags = HelpType.allCases.map { tag in
                .init(name: tag.rawValue,
                      color: tag.color,
                      isSelected: currentUserHelpTags.contains(where: { tag.rawValue == $0.rawValue })
                )
        }
    }
}
