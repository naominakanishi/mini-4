import SwiftUI
import Academy

public struct EquipmentTypeFilterButton: View {
    
    var equipmentType: EquipmentType
    var onTap: () -> ()
    
    // Review
    var typeColor: Color {
        switch equipmentType {
        case .all:
            return .gray
        case .iPad:
            return .adaPink
        case .pencil:
            return .adaYellow
        case .mac:
            return .adaPurple
        case .watch:
            return .adaGreen
        case .iPhone:
            return .adaLightBlue
        case .others:
            return .gray
        }
    }
    
    public init(equipmentType: EquipmentType, onTap: @escaping () -> ()) {
        self.equipmentType = equipmentType
        self.onTap = onTap
    }
    
    public var body: some View {
        Button(action: {
            onTap()
        }) {
            VStack {
                Text(equipmentType.rawValue)
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

struct EquipmentTypeFilterButton_Previews: PreviewProvider {
    static var previews: some View {
        EquipmentTypeFilterButton(equipmentType: .mac, onTap: {
            
        })
    }
}
