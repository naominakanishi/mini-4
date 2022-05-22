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
    
    var dayOfTheWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        let dayInWeek = dateFormatter.string(from: self)
        return dayInWeek
    }
    
    /// Returns date in dd/mm/yyyy format
    var dayMonthYear: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt-BR")
        formatter.timeZone = NSTimeZone(name: "UTC-3") as TimeZone?
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }
    
    /// Returns date in hh:mm format
    var hourMinute: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt-BR")
        formatter.timeZone = NSTimeZone(name: "UTC-3") as TimeZone?
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
