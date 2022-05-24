import SwiftUI
import Academy

public struct ProfilePictureView: View {
    public init(imageSelected: Binding<UIImage?> = .constant(nil), imageUrl: Binding<URL?>, size: CGFloat, userRole: Binding<Role?>) {
        self._imageSelected = imageSelected
        self._imageUrl = imageUrl
        self._userRole = userRole
        self.size = size
    }
    
    @Binding
    var imageSelected: UIImage?
    
    @Binding
    var imageUrl: URL?
    
    @Binding
    var userRole: Role?
    
    let size: CGFloat
    
    var circleColor: Color {
        switch userRole {
        case.coordinator:
            return .adaYellow
        case .jrMentor:
            return .adaPurple
        case .mentor:
            return .adaRed
        case .student:
            return .adaLightBlue
        default:
            return .gray
        }
    }
    
    public var body: some View {
        ZStack{
            AsyncImage(url: imageUrl, content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size, height: size)
            }, placeholder: {
                ProgressView()
                    .frame(width: size, height: size)
            })
                .overlay(
                    Circle()
                    .stroke(style: .init(
                        lineWidth: 10,
                        lineCap: .round,
                        lineJoin: .round
                    ))
                        .fill(.linearGradient(.init(
                            colors: [
                                circleColor,
                                circleColor,
                                (circleColor.opacity(0))]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing))
                    )
        }
        .background(
            .linearGradient(.init(
                colors: [(circleColor.opacity(0)),
                         (circleColor.opacity(0.2)),
                         (circleColor.opacity(0.4))]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing))
        .clipShape(Circle())
    }
    
    
    @ViewBuilder
    private var placeholderImage: some View {
        ZStack(alignment: .bottomTrailing){
            ZStack{
                Image(systemName: "person.fill")
                    .resizable()
                    .padding(30)
                    .frame(width: 90, height: 90)
                    .foregroundColor(Color(.white))
                    .overlay(
                        Circle()
                        .stroke(style: .init(
                            lineWidth: 10,
                            lineCap: .round,
                            lineJoin: .round
                        ))
                            .fill(.linearGradient(.init(
                                colors: [
                                    circleColor,
                                    circleColor,
                                    (circleColor.opacity(0))]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing))
                        )
            }
            .background(
                .linearGradient(.init(
                    colors: [(circleColor.opacity(0)),
                             (circleColor.opacity(0.2)),
                             (circleColor.opacity(0.4))]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
            .clipShape(Circle())
            ZStack(alignment: .center){
                Image(systemName: "person.crop.square")
                    .resizable()
                    .padding(8)
                    .frame(width: 35, height: 35)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
            .background(circleColor)
            .clipShape(Circle())
        }
        
    }
}
