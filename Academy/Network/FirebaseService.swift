import Foundation
import FirebaseDatabase

public final class FirebaseService {
    
    private var ref: DatabaseReference!
    
    public init() {
        self.ref = Database.database().reference()
    }
    
    // MARK: - Help requests
    func fetchHelpList() -> [Help] {
        // To do -> Fetch from /helps
        [
            .init(title: "Como configurar campanhas no Facebook Ads", description: "Precisava de muita ajuda com o meu projeto, to tentando usar a biblioteca Metal pra fazer formas primitivas, triangleStrip no caso, mas to me batendo bastante", type: .business, currentLocation: "Aquário", requestTimeInterval: Date().timeIntervalSince1970, assignee: nil),
            .init(title: "Arquitetura MVVM", description: "precisava de muita ajuda com o meu projeto, to tentando usar a biblioteca Metal pra fazer formas primitivas, triangleStrip no caso, mas to me batendo bastante", type: .code, currentLocation: "Discord - Lab 2", requestTimeInterval: Date().timeIntervalSince1970, assignee: nil),
            .init(title: "Modelo de negócios", description: "precisava de muita ajuda com o meu projeto, to tentando usar a biblioteca Metal pra fazer formas primitivas, triangleStrip no caso, mas to me batendo bastante", type: .business, currentLocation: "Lab 2", requestTimeInterval: Date().timeIntervalSince1970, assignee: nil),
            .init(title: "Frameworks da Apple", description: "precisava de muita ajuda com o meu projeto, to tentando usar a biblioteca Metal pra fazer formas primitivas, triangleStrip no caso, mas to me batendo bastante", type: .code, currentLocation: "Firecamp", requestTimeInterval: Date().timeIntervalSince1970, assignee: nil),
            .init(title: "Feedbacks do protótipo", description: "precisava de muita ajuda com o meu projeto, to tentando usar a biblioteca Metal pra fazer formas primitivas, triangleStrip no caso, mas to me batendo bastante", type: .design, currentLocation: "Copa", requestTimeInterval: Date().timeIntervalSince1970, assignee: nil),
            .init(title: "Ilustrações", description: "precisava de muita ajuda com o meu projeto, to tentando usar a biblioteca Metal pra fazer formas primitivas, triangleStrip no caso, mas to me batendo bastante", type: .design, currentLocation: "Enterprise", requestTimeInterval: Date().timeIntervalSince1970, assignee: nil),
            .init(title: "Como fazer um app multiplataforma?", description: "precisava de muita ajuda com o meu projeto, to tentando usar a biblioteca Metal pra fazer formas primitivas, triangleStrip no caso, mas to me batendo bastante", type: .code, currentLocation: "Lab 1", requestTimeInterval: Date().timeIntervalSince1970, assignee: nil),
            .init(title: "Como fazer um modelo de assinatura que funcione?", description: "precisava de muita ajuda com o meu projeto, to tentando usar a biblioteca Metal pra fazer formas primitivas, triangleStrip no caso, mas to me batendo bastante", type: .business, currentLocation: "Lab 3", requestTimeInterval: Date().timeIntervalSince1970, assignee: nil)
        ]
    }
    
    public func createNewHelpRequest(help: Help, completionHandler: @escaping () -> ()) {
        self.ref.child("help/\(help.id)/").setValue([
            "id": help.id,
            "title": help.title,
            "description" : help.description,
            "currentLocation" : help.currentLocation,
            "requestTimeInterval" : help.requestTimeInterval,
            "type" : help.type.rawValue
        ]) { (error: Error?, ref: DatabaseReference) in
            if let error = error {
                print("Help request failed: \(error)")
            } else {
                print("Help request saved successfully 🚀")
                completionHandler()
            }
        }
    }
    
    // MARK: - Announcement requests
    func fetchAnnouncementList() -> [Announcement] {
        // To do -> Fetch from /announcements
        [
            .init(fromUser: User(name: "André", imageName: "andre-memoji"), date: Date(), text: "precisava de muita ajuda com o meu projeto, to tentando usar a biblioteca Metal pra fazer formas primitivas, triangleStrip no caso, mas to me batendo bastante", isActive: true),
            .init(fromUser: User(name: "André", imageName: "andre-memoji"), date: Date(), text: "Hoje não vamos ter Get Together!!!", isActive: true),
                .init(fromUser: User(name: "André", imageName: "andre-memoji"), date: Date(), text: "precisava de muita ajuda com o meu projeto, to tentando usar a biblioteca Metal pra fazer formas primitivas, triangleStrip no caso, mas to me batendo bastante", isActive: true),
            .init(fromUser: User(name: "André", imageName: "andre-memoji"), date: Date(), text: "Hoje não vamos ter Get Together!!!", isActive: true),
                .init(fromUser: User(name: "André", imageName: "andre-memoji"), date: Date(), text: "precisava de muita ajuda com o meu projeto, to tentando usar a biblioteca Metal pra fazer formas primitivas, triangleStrip no caso, mas to me batendo bastante", isActive: true),
            .init(fromUser: User(name: "André", imageName: "andre-memoji"), date: Date(), text: "Hoje não vamos ter Get Together!!!", isActive: true),
            .init(fromUser: User(name: "André", imageName: "andre-memoji"), date: Date(), text: "precisava de muita ajuda com o meu projeto, to tentando usar a biblioteca Metal pra fazer formas primitivas, triangleStrip no caso, mas to me batendo bastante", isActive: true),
        ]
    }
    
    public func createNewAnnouncement(announcement: Announcement) {
        // To do -> Save announcemente on Firebase Realtime Database
        
    }
}
