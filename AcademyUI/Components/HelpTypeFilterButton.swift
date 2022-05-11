import SwiftUI
import Academy

public struct HelpTypeFilterButton: View {
    var helpType: HelpType
    var onTap: () -> ()
    
    // Review
    var typeColor: Color {
        switch helpType {
        case .business:
            return .blue
        case .code:
            return .green
        case .design:
            return .pink
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
            Text(helpType.rawValue)
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
                .background(typeColor)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .cornerRadius(16)
                .padding(.bottom, 8)
        }
    }
}

struct HelpTypeFilterButton_Previews: PreviewProvider {
    static var previews: some View {
        HelpTypeFilterButton(helpType: .business, onTap: {
            
        })
    }
}
