import SwiftUI

public struct AcademyTagModel: Identifiable {
    public let id = UUID()
    let name: String
    let color: Color
    let isSelected: Bool
    
    public init(name: String, color: Color, isSelected: Bool) {
        self.name = name
        self.color = color
        self.isSelected = isSelected
    }
}

public struct AcademyTag: View {
    
    let text: String
    let color: Color
    let isSelected: Bool
    
    public init(model: AcademyTagModel) {
        self.init(text: model.name, color: model.color, isSelected: model.isSelected)
    }
    public init(text: String, color: Color, isSelected: Bool) {
        self.text = text
        self.color = color
        self.isSelected = isSelected
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
            .opacity(isSelected ? 1 : 0.5)
    }
    
    
}
