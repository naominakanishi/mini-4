import Foundation
import SwiftUI

public extension Color {
    static let adaBackground = Color(red: 3/255, green: 10/255, blue: 28/255)
    static let adaRed = Color(red: 252/255, green: 65/255, blue: 76/255)
    static let adaPink = Color(red: 255/255, green: 75/255, blue: 118/255)
    static let adaPurple = Color(red: 200/255, green: 59/255, blue: 249/255)
    static let adaIndigo = Color(red: 95/255, green: 93/255, blue: 255/255)
    static let adaDarkBlue = Color(red: 44/255, green: 113/255, blue: 232/255)
    static let adaLightBlue = Color(red: 100/255, green: 210/255, blue: 255/255)
    static let adaGreen = Color(red: 76/255, green: 207/255, blue: 130/255)
    static let adaYellow = Color(red: 240/255, green: 214/255, blue: 94/255)
    
    static let adaDarkGray = Color(red: 19/255, green: 26/255, blue: 43/255)
}

public extension Color {
    func adaGradient(repeatCount count: Int = 5) -> LinearGradient {
        .init(colors: .init(repeating: self, count: count) + [.clear],
              startPoint: .topLeading,
              endPoint: .bottomTrailing)
    }
}

public extension Color {
    func reversedAdaGradient(repeatCount count: Int = 5) -> LinearGradient {
        .init(colors: [.clear] + .init(repeating: self, count: count),
              startPoint: .topLeading,
              endPoint: .bottomTrailing)
    }
}

public extension Color {
    func textFieldAdaGradient(repeatCount count: Int = 4) -> some View {
        LinearGradient(colors: [self.opacity(0.3), self.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing).opacity(0.6)
    }
}
