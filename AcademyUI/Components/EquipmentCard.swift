import SwiftUI
import Academy

public struct EquipmentCard: View {
    var equipment: Equipment
    
    var color: Color {
        switch equipment.type {
        case .iPad:
            return .adaPink
        case .mac:
            return .adaPurple
        case .watch:
            return .adaGreen
        case .pencil:
            return .adaYellow
        default:
            return .gray
        }
    }
    
    public init(equipment: Equipment) {
        self.equipment = equipment
    }
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(equipment.name)
                    .bold()
                    .padding(.bottom, 1)
                Text(equipment.status.rawValue)
                    .font(.system(size: 14, weight: .regular, design: .default))
            }
            Spacer()
            
            Button(action: {
                
            }) {
                VStack {
                    Text("Emprestar")
                        .foregroundColor(color)
                        .padding()
                        .font(.system(size: 14, weight: .bold, design: .default))
                }
            }
            .background(Color.white)
            .cornerRadius(8)
        }
        .foregroundColor(.white)
        .padding()
        .background(color.opacity(0.5))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(color, lineWidth: 2)
        )
        .padding(.vertical, 4)
    }
}

struct EquipmentCard_Previews: PreviewProvider {
    static var previews: some View {
        EquipmentCard(equipment: Equipment(id: "x", name: "iPad Pro", status: .available, type: .iPad))
    }
}
