import SwiftUI
import Academy
import AcademyUI
import FirebaseFirestore
import FirebaseStorage
import Firebase

final class DashboardViewModel: ObservableObject {
    
    struct HelpColumn: Identifiable {
        struct Help {
            let queuePosition: Int
            let helpModel: Academy.Help
        }
        let id = UUID()
        let name: String
        let color: Color
        let cards: [Help]
    }
    
    @Published
    private(set) var shouldShowEvents: Bool = false
    
    @Published
    private(set) var helpList: [HelpColumn] = []
    
    @Published
    private(set) var todayEvents: MonthModel?
    
    private let helpService = HelpListenerService()
    private let eventListener = CalendarEventListenerService()
    
    init() {
        helpService
            .listen(to: .all)
            .map { helpList in
                HelpType.allCases
                    .filter { $0 != .all }
                    .map { type in helpList.filter { $0.type == type }}
            }
            .map { groupedList in
                groupedList.compactMap { group -> HelpColumn? in
                    guard let type = group.first?.type
                    else { return nil }
                    
                    return HelpColumn(
                        name: type.rawValue,
                        color: type.color,
                        cards: group.enumerated().map { i, help in
                            .init(
                                queuePosition: i + 1,
                                helpModel: help
                            )
                        }
                    )
                }
            }
            .assign(to: &$helpList)
        
        $helpList
            .map { $0.count <= 2 }
            .assign(to: &$shouldShowEvents)
        
        eventListener
            .todayEvents
            .filter { !$0.isEmpty }
            .map { MonthModel(name: "Hoje", from: $0) }
            .assign(to: &$todayEvents)
    }
}
