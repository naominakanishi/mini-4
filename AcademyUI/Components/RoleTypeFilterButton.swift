import SwiftUI

public struct RoleTypeFilterButton: View {
    
    var role: String
    let typeColor: Color
    
    
    public init(role: String, typeColor: Color) {
        self.role = role
        self.typeColor = typeColor
    }
    
    public var body: some View {
        
        Text(role)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(typeColor.opacity(0.1))
            .font(.system(size: 16, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(typeColor, lineWidth: 1)
            )
            .padding(.vertical, 4)
            .padding(.leading, 4)
    }
}
