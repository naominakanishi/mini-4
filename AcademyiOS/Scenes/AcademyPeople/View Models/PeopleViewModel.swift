import SwiftUI
import Academy

class PeopleViewModel: ObservableObject {
    struct RoleFilterModel: Identifiable {
        let id = UUID()
        let color: Color
        let roleName: String
        let isSelected: Bool
    }
    
    struct UserModel: Identifiable {
        let id = UUID()
        let color: Color
        let imageName: String
        let name: String
        let user: AcademyUser
    }
    
    @Published
    private(set) var filterList: [RoleFilterModel] = []
    
    @Published
    private(set) var users: [UserModel] = []
    
    private let peopleListenerService = AcademyPeopleListenerService()
    private var selectedRole: Role = .all
    
    init() {
        loadRoles()
        loadPeople()
    }
    
    private func loadRoles() {
        let roles = Role.allCases
            .map {
                RoleFilterModel(
                    color: color(forRole: $0),
                    roleName: $0.rawValue,
                    isSelected: $0 == selectedRole)
            }
        filterList = roles
    }
    
    private func loadPeople() {
        select(role: .all)
    }
    
    func selectFilter(with id: UUID) {
        guard let selectedName = filterList.first(where: { $0.id == id })?.roleName,
              let selectedRole = Role.allCases.first(where: { $0.rawValue == selectedName })
        else { return }
        self.selectedRole = selectedRole
        select(role: selectedRole)
        loadRoles()
    }
    
    private func select(role: Role) {
        peopleListenerService
            .people(withRole: role)
            .map { users in
            users.map { user in
                UserModel.init(color: .red, //TODO: change color conform role
                               imageName: user.imageName,
                               name: user.name, user: user)
            }
        }
        .assign(to: &$users)
    }
    
    private func color(forRole role: Role) -> Color {
        switch role {
        case .all:
            return .gray
        case.coordinator:
            return .adaPink
        case .jrMentor:
            return .adaGreen
        case .mentor:
            return .adaPink
        case .student:
            return .adaLightBlue
        }
    }
}
