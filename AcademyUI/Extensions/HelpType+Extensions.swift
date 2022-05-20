import Academy
import SwiftUI
public extension HelpType {
    var color: Color {
        switch self {
        case .business:
            return .adaYellow
        case .code:
            return .adaGreen
        case .design:
            return .adaPink
        case .general:
            return .adaLightBlue
        case .all:
            return .gray
        }
    }
}
