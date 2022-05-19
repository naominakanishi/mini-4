import Foundation
import Academy
import Combine

final class EquipmentListViewModel: ObservableObject {

    private let waitlistService: EquipmentWaitlistService
    private let listenerService: EquipmentListenerService
    private let updatingService: EquipmentUpdatingService
    private let currentUser: AcademyUser
    
    @Published var equipmentList: [Equipment] = []
    @Published var filterChosen: EquipmentType = .all {
        didSet {
            selectFilter(equipmentType: filterChosen)
        }
    }
    
    private var cancellable: AnyCancellable?
    
    init(currentUser: AcademyUser, listenerService: EquipmentListenerService, updatingService: EquipmentUpdatingService, waitlistService: EquipmentWaitlistService) {
        self.currentUser = currentUser
        self.listenerService = listenerService
        self.updatingService = updatingService
        self.waitlistService = waitlistService
    }
    
    func selectFilter(equipmentType: EquipmentType) {
        cancellable?.cancel()
        cancellable = listenerService
            .listen(to: equipmentType)
            .replaceError(with: [])
            .assign(to: \.equipmentList, on: self)
    }
    
    func fetchEquipmentList() {
        listenerService
            .listen(to: .all)
            .assign(to: &$equipmentList)
    }
    
    func handleOnAppear() {
        selectFilter(equipmentType: .all)
    }
    
    func handleTapOnEquipmentButton(equipment: Equipment) {
        switch equipment.status {
        case .available:
            print("Equipment is available")
            var updatedEquipment = equipment
            updatedEquipment.status = .borrowed
            updatedEquipment.personWhoBorrowed = currentUser
            updatingService.execute(using: updatedEquipment)
        case .borrowed:
            print("Equipment is borrowed")
            if equipment.personWhoBorrowed?.id == currentUser.id {
                var updatedEquipment = equipment
                updatedEquipment.status = .available
                updatedEquipment.personWhoBorrowed = nil
                updatingService.execute(using: updatedEquipment)
            } else {
                waitlistService.addUserToWaitlist(equipment: equipment, user: currentUser)
            }
        case .maintenance:
            print("Equipment is on maintenance")
        }
    }
}
