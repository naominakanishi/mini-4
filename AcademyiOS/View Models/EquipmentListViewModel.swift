import Foundation
import Academy
import Combine

final class EquipmentListViewModel: ObservableObject {

    @Published var equipmentRepository = EquipmentRepository()
    @Published var equipmentList: [Equipment] = []
    
    private var cancellabels: Set<AnyCancellable> = []
    
    init() {
        fetchEquipmentList()
    }
    
    func fetchEquipmentList() {
        equipmentRepository.$equipmentList
            .assign(to: \.equipmentList, on: self)
            .store(in: &cancellabels)
    }
}
