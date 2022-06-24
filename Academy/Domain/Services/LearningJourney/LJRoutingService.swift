#if canImport(UIKit)
import UIKit
#endif

public struct LJRoutingService {
    
    public init() {}

    public func route() {
        guard let url = URL(string: "learningjourney://open")
        else { return }
        #if canImport(UIKit)
        UIApplication.shared.open(url)
        #endif
    }
}
