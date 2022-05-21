import Combine

public final class EquipmentUpdatingService {
    private let repository: EquipmentRepository
    
    init(repository: EquipmentRepository) {
        self.repository = repository
    }
    
    public convenience init() {
        self.init(repository: .shared)
    }
    
    public func execute(using equipment: Equipment) -> AnyPublisher<Bool, Error> {
        repository.update(equipment)
    }
}
