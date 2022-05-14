import Foundation

public struct HelpFilter {
    
    let http: FirebaseService
    
    public init() {
        self.init(http: FirebaseService())
    }
    
    internal init(http: FirebaseService) {
        self.http = http
    }
    
    public func fetchHelpList() -> [Help] {
        http.fetchHelpList()
    }
    
    public func filter(byType type: HelpType) -> [Help] {
        if type == .all {
            return fetchHelpList()
        } else {
            return http.fetchHelpList().filter { help in
                help.type == type
            }
        }
    }
}
