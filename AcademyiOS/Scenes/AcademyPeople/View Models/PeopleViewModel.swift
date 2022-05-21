import SwiftUI
import Academy

class PeopleViewModel: ObservableObject {
    struct RoleFilterModel: Identifiable {
        let id = UUID()
        let color: Color
        let roleName: String
    }
    
    struct UserModel: Identifiable {
        let id = UUID()
        let color: Color
        let imageName: String
        let name: String
    }
    
    @Published
    private(set) var filterList: [RoleFilterModel] = []
    
    @Published
    private(set) var users: [UserModel] = []
        
    private var allUsers: [AcademyUser] = [
        AcademyUser.init(id: "1", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: []),
        AcademyUser.init(id: "2", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: []),
        AcademyUser.init(id: "3", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: []),
        AcademyUser.init(id: "4", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: []),
        AcademyUser.init(id: "5", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: []),
        AcademyUser.init(id: "6", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: []),
        AcademyUser.init(id: "7", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: []),
        AcademyUser.init(id: "8", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: []),
        AcademyUser.init(id: "9", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: []),
        AcademyUser.init(id: "10", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: []),
        AcademyUser.init(id: "11", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: []),
        AcademyUser.init(id: "12", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: []),
        AcademyUser.init(id: "13", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: []),
        AcademyUser.init(id: "14", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: []),
        AcademyUser.init(id: "15", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: []),
        AcademyUser.init(id: "16", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: []),
        AcademyUser.init(id: "17", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: []),
        AcademyUser.init(id: "18", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: []),
        AcademyUser.init(id: "19", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: []),
        AcademyUser.init(id: "20", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: []),
        AcademyUser.init(id: "21", name: "Nome", email: "", imageName: "andre-memoji", status: Status.available, birthday: nil, role: Role.allCases.randomElement()!, helpTags: [])
    ]
    
    init() {
        loadRoles()
    }
    
    private func loadRoles() {
        let roles = Role.allCases
            .map {
                RoleFilterModel(
                    color: color(forRole: $0),
                    roleName: $0.rawValue)
            }
        filterList = roles
        selectFilter(with: filterList[0].id)
    }
    
    func selectFilter(with id: UUID) {
        guard let selectedName = filterList.first(where: { $0.id == id })?.roleName,
              let selectedRole = Role.allCases.first(where: { $0.rawValue == selectedName })
        else { return }
        let filteredUsers: [AcademyUser]
        switch selectedRole {
        case .all:
            filteredUsers = allUsers.map { $0 }
        default:
            filteredUsers = allUsers.filter { $0.role == selectedRole }
        }
        
        users = filteredUsers
            .map { user in
                return .init(
                    color: color(forRole: user.role ?? .all),
                    imageName: user.imageName,
                    name: user.name
                )
            }
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
