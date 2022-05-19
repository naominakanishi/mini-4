import Foundation

public struct Equipment: Codable, Identifiable {
    public var id: String
    public var name: String
    public var status: EquipmentStatus
    public var type: EquipmentType
    public var waitlist: [AcademyUser]?
    public var personWhoBorrowed: AcademyUser?
    
    public init(id: String, name: String, status: EquipmentStatus, type: EquipmentType) {
        self.id = id
        self.name = name
        self.status = status
        self.type = type
    }
}

public enum EquipmentStatus: String, Codable {
    case available = "Disponível"
    case borrowed = "Emprestado"
    case maintenance = "Em manutenção"
}

public enum EquipmentType: String, Codable {
    case all = "Todos"
    case iPhone = "iPhone"
    case iPad = "iPad"
    case pencil = "Apple Pencil"
    case mac = "Mac"
    case watch = "Apple Watch"
    case others = "Outros"
}
