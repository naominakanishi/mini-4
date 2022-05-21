import Combine

public final class EquipmentWaitlistService {
    private let repository: EquipmentRepository
    
    init(repository: EquipmentRepository) {
        self.repository = repository
    }
    
    public convenience init() {
        self.init(repository: .shared)
    }
    
    public func addUserToWaitlist(equipment: Equipment, user: AcademyUser) -> AnyPublisher<Bool, Error> {
        var updatedEquipment = equipment
        updatedEquipment.waitlist = []
        updatedEquipment.waitlist!.append(user)
        return repository.update(updatedEquipment)
    }
}
