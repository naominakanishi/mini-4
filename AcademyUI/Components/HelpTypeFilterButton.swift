import SwiftUI
import Academy

public struct HelpTypeFilterButton: View {
    var helpType: HelpType
    var onTap: () -> ()
    
    // Review
    var typeColor: Color {
        switch helpType {
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
    
    public init(helpType: HelpType, onTap: @escaping () -> ()) {
        self.helpType = helpType
        self.onTap = onTap
    }
    
    public var body: some View {
        Button(action: {
            onTap()
        }) {
            VStack {
                Text(helpType.rawValue)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(typeColor.opacity(0.1))
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(typeColor, lineWidth: 1)
            )
            .padding(.vertical, 4)
            .padding(.leading, 4)
        }
    }
}

struct HelpTypeFilterButton_Previews: PreviewProvider {
    static var previews: some View {
        HelpTypeFilterButton(helpType: .business, onTap: {
            
        })
    }
}
