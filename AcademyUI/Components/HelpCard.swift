import SwiftUI
import Academy

public struct HelpCard: View {
    
    var queuePosition: Int
    var isFromUser: Bool
    var helpModel: Help
    var assignHelpHandler: () -> ()
    var completeHelpHandler: () -> ()
    @State var showDetails: Bool = false
    
    // Review
    var typeColor: Color {
        switch helpModel.type {
        case .business:
            return .adaGreen
        case .code:
            return .adaPurple
        case .design:
            return .adaDarkBlue
        case.general:
            return .adaRed
        case .all:
            return .gray
        }
    }
    
    public init(queuePosition: Int, isFromUser: Bool, helpModel: Help, assignHelpHandler: @escaping () -> (), completeHelpHandler: @escaping () -> ()) {
        self.queuePosition = queuePosition
        self.isFromUser = isFromUser
        self.helpModel = helpModel
        self.assignHelpHandler = assignHelpHandler
        self.completeHelpHandler = completeHelpHandler
    }
    
    public var body: some View {
        VStack {
            HStack {
                Text("\(queuePosition)")
                    .font(.academy.queuePosition)
                    .foregroundColor(Color.white)
                    .padding(.trailing)
                    .padding(.leading, 8)
                
                VStack(alignment: .leading) {
                    Text(helpModel.title)
                        .font(.academy.helpTitle)
                        .padding(.bottom, 2)
                        .foregroundColor(Color.white)
                    
                    Text(helpModel.currentLocation)
                        .font(.academy.helpDescription)
                        .foregroundColor(Color.white)
                }
                
                Spacer()
                
                switch helpModel.status {
                case .waitingForHelp:
                    Text(helpModel.requestDate.getFormattedDate())
                        .font(.academy.helpDescription)
                        .foregroundColor(Color.white)
                case .beingHelped:
                    ProfilePictureView(imageUrl: .constant(.init(string: helpModel.assignee!.imageName)), size: 50, userRole: .constant(helpModel.assignee!.role!))
                case .done:
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .foregroundColor(.adaGreen)
                }
            }
            
            if showDetails {
                VStack {
                    Divider()
                        .background(typeColor)
                    
                    HStack {
                        ProfilePictureView(imageUrl: .constant(.init(string: helpModel.user.imageName)), size: 60, userRole: .constant(helpModel.user.role!))
                            .padding(.trailing)
                        
                        Text(helpModel.user.name)
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                    HStack {
                        Text(helpModel.description)
                            .padding(.bottom, 8)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .padding(.vertical)
                    
                    HStack {
                        if isFromUser {
                            Button(action: {
                                print("Resolvido")
                                completeHelpHandler()
                            }) {
                                HStack {
                                    Spacer()
                                    Text("Resolvido")
                                        .bold()
                                    Spacer()
                                }
                                .padding(.vertical, 8)
                                .background(Color.adaLightBlue)
                                .cornerRadius(8)
                                .foregroundColor(.white)
                                .padding(.leading, 4)
                            }
                        } else {
                            Button(action: {
                                print("Ajudar")
                                assignHelpHandler()
                            }) {
                                HStack {
                                    Spacer()
                                    Text(helpModel.status == .beingHelped ? "Recebendo ajuda" : "Ajudar")
                                        .bold()
                                    Spacer()
                                }
                                .padding(.vertical, 8)
                                .background(Color.white)
                                .opacity(helpModel.status == .beingHelped ? 0.5 : 1)
                                .cornerRadius(8)
                                .foregroundColor(.black)
                                .padding(.trailing, 4)
                            }
                            .disabled(helpModel.status == .beingHelped)
                        }
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
        .onLongPressGesture(minimumDuration: 0.01, pressing: { _ in }) {
            withAnimation {
                showDetails.toggle()
            }
        }
        
    }
}

protocol AcademyFont {
    static var queuePosition: Font { get }
    static var helpTitle: Font { get }
    static var helpDescription: Font { get }
    static var eventEmoji: Font { get }
    static var eventName: Font { get }
    static var eventTime: Font { get }
}

enum DefaultAcademyFont: AcademyFont {
    static var queuePosition: Font {
        .system(size: 40, weight: .bold, design: .default)
    }
    
    static var helpTitle: Font {
        .system(.body)
        .bold()
    }
    
    static var helpDescription: Font {
        .system(size: 16, weight: .regular, design: .rounded)
    }
    
    static var eventEmoji: Font {
        .system(size: 24, weight: .regular, design: .default)
    }
    
    static var eventName: Font {
        .system(size: 14, weight: .regular, design: .default)
    }
    
    static var eventTime: Font {
        .system(size: 14, weight: .regular, design: .default)
    }
}

enum LargeAcademyFont: AcademyFont {
    static var queuePosition: Font {
        .system(size: 48, weight: .bold, design: .default)
    }
    
    static var helpTitle: Font {
        .system(size: 32, weight: .bold)
    }
    
    static var helpDescription: Font {
        .system(size: 28, weight: .regular, design: .rounded)
    }
    
    static var eventEmoji: Font {
        .system(size: 48, weight: .regular, design: .default)
    }
    
    static var eventName: Font {
        .system(size: 32, weight: .bold, design: .default)
    }
    
    static var eventTime: Font {
        .system(size: 30, weight: .regular, design: .default)
    }
}

extension Font {
    static var academy: AcademyFont.Type {
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone) {
            return DefaultAcademyFont.self
        }
        else {
            return LargeAcademyFont.self
        }
    }
}
