import Foundation

public struct Equipment: Codable, Identifiable {
    public var id: String
    public var name: String
    public var status: EquipmentStatus
    public var type: EquipmentType
    public var waitlist: [User]?
    public var personWhoBorrowed: User?
    
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
    case iPad = "iPad"
    case mac = "Mac"
    case watch = "Apple Watch"
    case pencil = "Apple Pencil"
}