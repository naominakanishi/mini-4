import SwiftUI
import Academy

public struct HelpCard: View {
    
    var helpModel: Help
    var assignHelpHandler: () -> ()
    var completeHelpHandler: () -> ()
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
    
    public init(helpModel: Help, assignHelpHandler: @escaping () -> (), completeHelpHandler: @escaping () -> ()) {
        self.helpModel = helpModel
        self.assignHelpHandler = assignHelpHandler
        self.completeHelpHandler = completeHelpHandler
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
                
                switch helpModel.status {
                case .waitingForHelp:
                    Text(helpModel.requestDate.getFormattedDate())
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundColor(Color.white)
                case .beingHelped:
                    Image("andre-memoji")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                case .done:
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .foregroundColor(.adaGreen)
                }
            }
            
            if showDetails {
                Divider()
                    .background(typeColor)
                
                HStack {
                    Text(helpModel.description)
                        .padding(.bottom, 8)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.vertical)
                
                HStack {
                    Button(action: {
                        print("Ajudar")
                        assignHelpHandler()
                    }) {
                        HStack {
                            Spacer()
                            Text("Ajudar")
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(8)
                        .foregroundColor(.black)
                        .padding(.trailing, 4)
                    }
                    
                    Button(action: {
                        print("Resolvido")
                        completeHelpHandler()
                    }) {
                        HStack {
                            Spacer()
                            Text("Resolvido")
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        .background(Color.adaLightBlue)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .padding(.leading, 4)
                    }
                }
                
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
        .onTapGesture {
            withAnimation {
                showDetails.toggle()
            }
        }
    }
}
