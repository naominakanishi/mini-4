import Combine

public final class EquipmentListenerService {
    private let repository: EquipmentRepository
    
    init(repository: EquipmentRepository) {
        self.repository = repository
    }
    
    public convenience init() {
        self.init(repository: .shared)
    }
    
    public func listen(to type: EquipmentType) -> AnyPublisher<[Equipment], Never> {
        return repository
            .readingPublisher
            .decode(type: [Equipment].self, decoder: JSONDecoder.firebaseDecoder)
            .replaceError(with: [])
            .map { equipments -> [Equipment] in
                if type == .all { return equipments }
                return equipments.filter { $0.type == type }
            }
            .eraseToAnyPublisher()
    }
}
