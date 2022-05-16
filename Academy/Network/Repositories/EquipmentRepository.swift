import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

public final class EquipmentRepository: ObservableObject {
    
    private let path = "equipment"
    private let store = Firestore.firestore()
    
    @Published public var equipmentList: [Equipment] = []
    
    public init() {}
    
    public func read() -> AnyPublisher<[Equipment], Never>{
        let publisher = PassthroughSubject<[Equipment], Never>()
        store.collection(path).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            let equipmentList: [Equipment] = snapshot?.documents.compactMap {
                do {
                    return try $0.data(as: Equipment.self)
                } catch {
                    print(error.localizedDescription)
                    return nil
                }
            } ?? []
            
            publisher.send(equipmentList)
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    public func create(_ equipment: Equipment) {
        do {
            _ = try store.collection(path).addDocument(from: equipment)
        } catch {
            print(error.localizedDescription)
        }
    }
}
