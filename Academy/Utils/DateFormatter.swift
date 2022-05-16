import Foundation
import SwiftUI

public extension Date {
    func getFormattedDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt-BR")
        formatter.timeZone = NSTimeZone(name: "UTC-3") as TimeZone?
        
        let calendar = Calendar.current
        let isToday = calendar.isDateInToday(self)
        
        if isToday {
            formatter.dateFormat = "HH:mm"
            return "Hoje às " + formatter.string(from: self)
        } else {
            formatter.dateFormat = "MM/dd/yyyy"
            return formatter.string(from: self)
        }
    }
}
