import Foundation
import SwiftUI

public extension Color {
    static let adaBackground = Color(red: 3/255, green: 10/255, blue: 28/255)
    static let adaLightBlue = Color(red: 22/255, green: 199/255, blue: 255/255)
    static let adaPink = Color(red: 238/255, green: 27/255, blue: 242/255)
    static let adaGreen = Color(red: 161/255, green: 242/255, blue: 27/255)
    static let adaYellow = Color(red: 255/255, green: 172/255, blue: 47/255)
    static let adaPurple = Color(red: 83/255, green: 60/255, blue: 222/255)
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
