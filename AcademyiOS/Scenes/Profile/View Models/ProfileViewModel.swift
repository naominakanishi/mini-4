//
//  ProfileViewModel.swift
//  AcademyiOS
//
//  Created by HANNA P C FERREIRA on 17/05/22.
//

import Foundation
import Academy
import Combine

final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var announcementList: [Announcement] = []
    
    @Published private(set) var activeAnnouncements: [Announcement] = []
    
    private var cancellabels: Set<AnyCancellable> = []
    
    private let announcementUpdatingService: AnnouncementUpdatingService
    private let announcementListenerService: AnnouncementListenerService
    
    init(announcementUpdatingService: AnnouncementUpdatingService,
         announcementListenerService: AnnouncementListenerService
    ) {
        self.announcementUpdatingService = announcementUpdatingService
        self.announcementListenerService = announcementListenerService
        
        bindToRepository()
    }
    
    private func bindToRepository() {
        announcementListenerService
            .listen()
            .assign(to: &$announcementList)
        announcementListenerService
            .activeAnnouncements
            .assign(to: &$activeAnnouncements)
    }
}
