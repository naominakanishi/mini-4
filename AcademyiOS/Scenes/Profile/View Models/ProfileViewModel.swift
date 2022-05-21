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
    var displayName: String = ""
    @Published
    private(set) var helpTags: [AcademyTagModel] = []
    @Published
    var birthday: Date = .now
    @Published
    var currentRole: String?
    @Published
    var imageSelected: UIImage?
    
    @Published
    var imageUrl: URL?
    
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
    var cancelBag: [AnyCancellable] = []
    
    init() {
        userListenerService = .init()
        userUpdatingService = .init()
        
        renderHelpTags()
        
        userListenerService
            .listener
            .sink { user in
                self.currentUser = user
                
                if let birthday = user.birthday {
                    self.birthday = Date(timeIntervalSince1970: birthday)
                }
                self.imageUrl = URL(string: user.imageName)
                self.currentUserHelpTags = user.helpTags ?? []
                self.displayName = user.name
                self.currentRole = user.role?.rawValue ?? Role.student.rawValue
                self.renderHelpTags()
            }
            .store(in: &cancelBag)
        
        $imageSelected
            .flatMap { imageData -> AnyPublisher<URL?, Never> in
                self.imageUrl = nil
                guard let imageData = imageData?.pngData(),
                      let user = self.currentUser
                else {
                    return Just(nil)
                        .eraseToAnyPublisher()
                }
                return self.userUpdatingService
                    .updateImage(imageData, forUser: user)
                    .map { $0 }
                    .replaceError(with: nil)
                    .eraseToAnyPublisher()
            }
            .flatMap { url in self.save(url) }
            .compactMap { $0?.imageName }
            .map { URL(string: $0) }
            .assign(to: &$imageUrl)
    }
    
    func save(_ imageURL: URL? = nil) -> AnyPublisher<AcademyUser?, Never> {
        guard let currentUser = currentUser else {
            return Just<AcademyUser?>(nil)
                .eraseToAnyPublisher()
        }
        let role = Role.allCases.first(where: { $0.rawValue == currentRole }) ?? .student
        
        return self.userUpdatingService.update(with:
                .init(
                    id: currentUser.id,
                    name: displayName,
                    email: currentUser.email,
                    imageName: imageURL?.absoluteString ?? self.imageUrl?.absoluteString ?? currentUser.imageName,
                    status: currentUser.status,
                    birthday: birthday.timeIntervalSince1970,
                    role: role,
                    helpTags: self.currentUserHelpTags
                )
        )
        .flatMap { Just<AcademyUser?>($0) }
        .breakpointOnError()
        .replaceError(with: nil)
        .eraseToAnyPublisher()
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
        helpTags = HelpType.allCases
            .filter { $0 != .all}
            .map { tag in
                    .init(name: tag.rawValue,
                          color: tag.color,
                          isSelected: currentUserHelpTags.contains(where: { tag.rawValue == $0.rawValue })
                    )
            }
    }
}
