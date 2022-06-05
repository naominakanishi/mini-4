import SwiftUI
import Academy

@available(tvOS, unavailable)
public struct EquipmentCard: View {
    var isBorrowedByUser: Bool
    var equipment: Equipment
    var onButtonTap: () -> ()
    
    @State var showWaitlist: Bool = false
    
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
        case .iPhone:
            return .adaLightBlue
        default:
            return .gray
        }
    }
    
    var buttonText: String {
        switch equipment.status {
        case .available:
            return "Emprestar"
        case .borrowed:
            if isBorrowedByUser {
                return "Devolver"
            } else {
                return "Entrar na fila"
            }
        case .maintenance:
            return "Em manutenção"
        }
    }
    
    var statusText: String {
        switch equipment.status {
        case .available:
            return "Disponível"
        case .borrowed:
            if isBorrowedByUser {
                return "Emprestado para você"
            } else {
                return "Emprestado para \(equipment.personWhoBorrowed!.name)"
            }
        case .maintenance:
            return "Em manutenção"
        }
    }
    
    public init(isBorrowedByUser: Bool, equipment: Equipment, onButtonTap: @escaping () -> ()) {
        self.isBorrowedByUser = isBorrowedByUser
        self.equipment = equipment
        self.onButtonTap = onButtonTap
    }
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(equipment.name)
                    .bold()
                    .padding(.bottom, 1)
                Text(statusText)
                    .font(.system(size: 14, weight: .regular, design: .default))
            }
            Spacer()
            
            Button(action: {
                onButtonTap()
            }) {
                VStack {
                    Text(buttonText)
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
        .onTapGesture {
            showWaitlist.toggle()
            print("Should show waitlist?", showWaitlist)
        }
    }
}

//struct EquipmentCard_Previews: PreviewProvider {
//    static var previews: some View {
//        EquipmentCard(equipment: Equipment(id: "x", name: "iPad Pro", status: .available, type: .iPad))
//    }
//}
