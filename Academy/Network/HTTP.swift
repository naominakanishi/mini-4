import Foundation

struct HTTP {
    // MARK: - Help requests
    func fetchHelpList() -> [Help] {
        // To do -> Fetch from /helps
        [
            .init(title: "Como configurar campanhas no Facebook Ads", description: "Precisava de muita ajuda com o meu projeto, to tentando usar a biblioteca Metal pra fazer formas primitivas, triangleStrip no caso, mas to me batendo bastante", type: .business, currentLocation: "Aquário", requestDate: Date(), assignee: nil),
            .init(title: "Arquitetura MVVM", description: "precisava de muita ajuda com o meu projeto, to tentando usar a biblioteca Metal pra fazer formas primitivas, triangleStrip no caso, mas to me batendo bastante", type: .code, currentLocation: "Discord - Lab 2", requestDate: Date(), assignee: nil),
            .init(title: "Modelo de negócios", description: "precisava de muita ajuda com o meu projeto, to tentando usar a biblioteca Metal pra fazer formas primitivas, triangleStrip no caso, mas to me batendo bastante", type: .business, currentLocation: "Lab 2", requestDate: Date(timeIntervalSince1970: 1649639206), assignee: nil),
            .init(title: "Frameworks da Apple", description: "precisava de muita ajuda com o meu projeto, to tentando usar a biblioteca Metal pra fazer formas primitivas, triangleStrip no caso, mas to me batendo bastante", type: .code, currentLocation: "Firecamp", requestDate: Date(), assignee: nil),
            .init(title: "Feedbacks do protótipo", description: "precisava de muita ajuda com o meu projeto, to tentando usar a biblioteca Metal pra fazer formas primitivas, triangleStrip no caso, mas to me batendo bastante", type: .design, currentLocation: "Copa", requestDate: Date(), assignee: nil),
            .init(title: "Ilustrações", description: "precisava de muita ajuda com o meu projeto, to tentando usar a biblioteca Metal pra fazer formas primitivas, triangleStrip no caso, mas to me batendo bastante", type: .design, currentLocation: "Enterprise", requestDate: Date(), assignee: nil),
            .init(title: "Como fazer um app multiplataforma?", description: "precisava de muita ajuda com o meu projeto, to tentando usar a biblioteca Metal pra fazer formas primitivas, triangleStrip no caso, mas to me batendo bastante", type: .code, currentLocation: "Lab 1", requestDate: Date(), assignee: nil),
            .init(title: "Como fazer um modelo de assinatura que funcione?", description: "precisava de muita ajuda com o meu projeto, to tentando usar a biblioteca Metal pra fazer formas primitivas, triangleStrip no caso, mas to me batendo bastante", type: .business, currentLocation: "Lab 3", requestDate: Date(), assignee: nil)
        ]
    }
    
    func createNewHelpRequest(help: Help) {
        // To do -> Save Help on Firebase Realtime Database
        
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
    
    func createNewAnnouncement(announcement: Announcement) {
        // To do -> Save announcemente on Firebase Realtime Database
        
    }
}
