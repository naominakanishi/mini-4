import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class CalendarEventsRepository: ObservableObject {
    
    static let shared = CalendarEventsRepository()
    
    private let path = "events"
    private let store = Firestore.firestore()
    
    let readingPublisher = CurrentValueSubject<Data, Never>(.emptyJson)
    
    init() {
        read()
    }
    
    func create(eventData data: [String: Any], id: String) -> AnyPublisher<Bool, Error> {
        let response = PassthroughSubject<Bool, Error>()
        store.collection(path).document(id).setData(data) {
            if let _ = $0 {
                response.send(false)
                return
            }
            response.send(true)
        }
        return response
            .eraseToAnyPublisher()
    }
    
    private func read() {
        store.collection(path).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        
            guard let snapshot = snapshot else {
                fatalError()
            }
            
            let dictionaries: [[String: Any]] = snapshot.documents.map { $0.data() }
            do {
                let data = try JSONSerialization.data(withJSONObject: dictionaries, options: [])
//                self.readingPublisher.send(data)
            } catch {
                print("DEU RUM!", error)
            }
        }
        
        let mock = [
            CalendarEvent(id: UUID().uuidString,
                          title: "Timed event",
                          emoji: "🤡",
                          fullDay: false,
                          startDateTimeInterval: Date.now.timeIntervalSince1970,
                          endDateTimeInterval: Date.now.advanced(by: 10000).timeIntervalSince1970
            ),
            CalendarEvent(id: UUID().uuidString,
                          title: "All day",
                          emoji: "📅",
                          fullDay: true,
                          startDateTimeInterval: Date.now.timeIntervalSince1970,
                          endDateTimeInterval: Date.now.advanced(by: 10000).timeIntervalSince1970
            ),
            CalendarEvent(id: UUID().uuidString,
                          title: "Ontem",
                          emoji: "👨‍🌾",
                          fullDay: true,
                          startDateTimeInterval: Calendar.current.date(byAdding: .day, value: -1, to: .now)!.timeIntervalSince1970,
                          endDateTimeInterval: Calendar.current.date(byAdding: .day, value: -1, to: .now)!.advanced(by: 10000).timeIntervalSince1970
            ),
        ]
        let data = try! JSONEncoder().encode(mock)
        readingPublisher.send(data)
    }
    
    func update(_ event: CalendarEvent) -> AnyPublisher<Bool, Error> {
        let response = PassthroughSubject<Bool, Error>()
        do {
            try store.collection(path).document(event.id)
                .setData(from: event) {
                if let error = $0 {
                    response.send(false)
                    return
                }
                    
                response.send(true)
            }
        } catch {
            return Fail(outputType: Bool.self, failure: error)
                .eraseToAnyPublisher()
        }
        
        return response
            .eraseToAnyPublisher()
    }
}

