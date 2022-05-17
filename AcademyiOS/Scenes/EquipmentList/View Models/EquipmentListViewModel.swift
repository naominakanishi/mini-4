import Foundation
import Academy
import Combine

final class EquipmentListViewModel: ObservableObject {

    private let listener: EquipmentListenerService
    
    @Published var equipmentList: [Equipment] = []
    @Published var filterChosen: EquipmentType = .all {
        didSet {
            selectFilter(equipmentType: filterChosen)
        }
    }
    
    private var cancellable: AnyCancellable?
    
    init(listener: EquipmentListenerService) {
        self.listener = listener
    }
    
    func selectFilter(equipmentType: EquipmentType) {
        cancellable?.cancel()
        cancellable = listener
            .listen(to: equipmentType)
            .replaceError(with: [])
            .assign(to: \.equipmentList, on: self)
    }
    
    func fetchEquipmentList() {
        listener
            .listen(to: .all)
            .assign(to: &$equipmentList)
    }
    
    func handleOnAppear() {
        selectFilter(equipmentType: .all)
    }
    
}
