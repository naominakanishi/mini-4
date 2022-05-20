import SwiftUI

public struct AcademyTag: View {
    
    var text: String
    let color: Color
    
    
    public init(text: String, color: Color) {
        self.text = text
        self.color = color
    }
    
    public var body: some View {
        
        Text(text)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(color.opacity(0.1))
            .font(.system(size: 16, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(color, lineWidth: 1)
            )
            .padding(.vertical, 4)
            .padding(.leading, 4)
    }
}
