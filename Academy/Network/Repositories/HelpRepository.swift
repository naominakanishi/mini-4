import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

public final class HelpRepository: ObservableObject {
    
    private let path = "help"
    private let store = Firestore.firestore()
    @Published public var helpList: [Help] = []
    
    public init() {
        read()
    }
    
    public func create(_ help: Help) {
        do {
            _ = try store.collection(path).addDocument(from: help)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read() {
        store.collection(path).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            self.helpList = snapshot?.documents.compactMap {
                let data = try? $0.data(as: Help.self)
                return data
            } ?? []
            
            self.sortHelpList()
        }
    }
    
    func update(_ help: Help) {
        // To do
    }
    
    func delete(_ helpId: String) {
        // To do
    }
    
    // Review
    private func sortHelpList() {
        self.helpList = self.helpList.sorted { helpA, helpB in
            helpA.requestTimeInterval < helpB.requestTimeInterval
        }
    }
}
