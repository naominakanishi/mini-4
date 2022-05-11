import Foundation

public struct HelpFilter {
    
    let http: HTTP
    
    public init() {
        self.init(http: HTTP())
    }
    
    internal init(http: HTTP) {
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
