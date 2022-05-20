import UIKit

public struct LJRoutingService {
    
    public init() {}

    public func route() {
        guard let url = URL(string: "learningjourney://open")
        else { return }
        UIApplication.shared.open(url)
    }
}
