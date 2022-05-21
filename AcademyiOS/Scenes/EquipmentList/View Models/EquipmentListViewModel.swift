import Foundation
import Academy
import Combine

final class EquipmentListViewModel: ObservableObject {
    struct EquipmentModel: Identifiable {
        let id = UUID()
        let isBorrowed: Bool
        let equipment: Equipment
    }
    
    private let waitlistService: EquipmentWaitlistService
    private let listenerService: EquipmentListenerService
    private let updatingService: EquipmentUpdatingService
    private let userListenerService = UserListenerService()
    
    @Published var equipmentList: [EquipmentModel] = []
    @Published var filterChosen: EquipmentType = .all {
        didSet {
            selectFilter(equipmentType: filterChosen)
        }
    }
    
    private var cancellable: AnyCancellable?
    private var cancelBag: [AnyCancellable] = []
    
    init(listenerService: EquipmentListenerService, updatingService: EquipmentUpdatingService, waitlistService: EquipmentWaitlistService) {
        self.listenerService = listenerService
        self.updatingService = updatingService
        self.waitlistService = waitlistService
    }
    
    func selectFilter(equipmentType: EquipmentType) {
        Publishers.CombineLatest(userListenerService.listener, listenerService.listen(to: equipmentType))
            .map { user, equipments in
                equipments.map { equipment in
                    EquipmentModel(isBorrowed: equipment.personWhoBorrowed?.id == user.id,
                    equipment: equipment)
                }
            }
            .replaceError(with: [])
            .assign(to: &$equipmentList)
    }
    
    func fetchEquipmentList() {
        selectFilter(equipmentType: .all)
    }
    
    func handleOnAppear() {
        selectFilter(equipmentType: .all)
    }
    
    func handleTapOnEquipmentButton(equipment: Equipment) {
        _ = userListenerService
            .listener
            .prefix(1)
            .flatMap { currentUser -> AnyPublisher<Bool, Error> in
                switch equipment.status {
                case .available:
                    print("Equipment is available")
                    var updatedEquipment = equipment
                    updatedEquipment.status = .borrowed
                    updatedEquipment.personWhoBorrowed = currentUser
                    return self.updatingService.execute(using: updatedEquipment)
                case .borrowed:
                    print("Equipment is borrowed")
                    if equipment.personWhoBorrowed?.id == currentUser.id {
                        var updatedEquipment = equipment
                        updatedEquipment.status = .available
                        updatedEquipment.personWhoBorrowed = nil
                        return self.updatingService.execute(using: updatedEquipment)
                    } else {
                        return self.waitlistService.addUserToWaitlist(equipment: equipment, user: currentUser)
                    }
                case .maintenance:
                    return Just(false)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }
            }
    }
}
