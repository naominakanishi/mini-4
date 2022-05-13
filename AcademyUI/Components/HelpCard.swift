import SwiftUI
import Academy

public struct HelpCard: View {
    
    var helpModel: Help
    @State var showDetails: Bool = false
    
    // Review
    var typeColor: Color {
        switch helpModel.type {
        case .business:
            return .adaYellow
        case .code:
            return .adaGreen
        case .design:
            return .adaPink
        case .all:
            return .gray
        }
    }
    
    public init(helpModel: Help) {
        self.helpModel = helpModel
    }
    
    public var body: some View {
        VStack {
            HStack {
                Text("1")
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .foregroundColor(Color.white)
                    .padding(.trailing)
                    .padding(.leading, 8)
                
                VStack(alignment: .leading) {
                    Text(helpModel.title)
                        .bold()
                        .padding(.bottom, 2)
                        .foregroundColor(Color.white)
                    
                    Text(helpModel.currentLocation)
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundColor(Color.white)
                }
                
                Spacer()
                
                Text(helpModel.requestDate.getFormattedDate())
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .foregroundColor(Color.white)
                
            }
            
            if showDetails {
                Text(helpModel.description)
                    .padding(.top, 8)
                
                // TO DO: Add other help data here
                
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(typeColor.opacity(0.2))
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.1), radius: 16, x: 0, y: 0)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(typeColor, lineWidth: 2)
        )
        .padding(.horizontal)
        .padding(.bottom, 4)
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
            .preferredColorScheme(.dark)
    }
}
