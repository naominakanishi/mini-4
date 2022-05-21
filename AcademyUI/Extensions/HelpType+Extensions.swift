import Academy
import SwiftUI
public extension HelpType {
    var color: Color {
        switch self {
        case .business:
            return .adaGreen
        case .code:
            return .adaPurple
        case .design:
            return .adaDarkBlue
        case .general:
            return .adaRed
        case .all:
            return .gray
        }
    }
}
