import SwiftUI
import Academy

struct HelpCard: View {
    var helpModel: Help
    
    var typeColor: Color {
        switch helpModel.type {
        case .business:
            return .blue
        case .code:
            return .green
        case .design:
            return .pink
        }
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt-BR")
        formatter.timeZone = NSTimeZone(name: "UTC-3") as TimeZone?
        if isToday {
            formatter.dateFormat = "HH:mm"
            return "Hoje às " + formatter.string(from: helpModel.requestDate)
        } else {
            formatter.dateFormat = "MM/dd/yyyy"
            return formatter.string(from: helpModel.requestDate)
        }
    }
    
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(helpModel.requestDate)
    }
    
    @State var showDetails: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Text(helpModel.type.rawValue)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 4)
                            .background(typeColor)
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .cornerRadius(16)
                        
                        Text(formattedDate)
                            .padding(.leading, 8)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                    }
                    .padding(.bottom, 8)
                    
                    Text(helpModel.title)
                        .bold()
                    
                    if showDetails {
                        Text(helpModel.description)
                            .padding(.top, 8)
                    }
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.1), radius: 16, x: 0, y: 0)
            .padding(.horizontal)
        }
//        .onTapGesture {
//            withAnimation {
//                showDetails.toggle()
//            }
//        }
    }
}

struct HelpCard_Previews: PreviewProvider {
    static var previews: some View {
        HelpCard(helpModel: .init(title: "Pode crerrr", description: "jsdnjsnajksdnjlsanjsdn asnjasnsdj asnsajn asndsjns", type: .business, currentLocation: "Caverna de cima", requestDate: Date(), assignee: nil))
    }
}
