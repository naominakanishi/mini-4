import SwiftUI

public struct ProfilePictureView: View {
    public init(imageSelected: Binding<UIImage?> = .constant(nil), imageUrl: Binding<URL?>, size: CGFloat) {
        self._imageSelected = imageSelected
        self._imageUrl = imageUrl
        self.size = size
    }
    
    
    @Binding
    var imageSelected: UIImage?
    
    @Binding
    var imageUrl: URL?
    
    let size: CGFloat
    
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
                                Color.adaLightBlue,
                                Color.adaLightBlue,
                                (Color.adaLightBlue.opacity(0))]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing))
                    )
        }
        .background(
            .linearGradient(.init(
                colors: [(Color.adaLightBlue.opacity(0)),
                         (Color.adaLightBlue.opacity(0.2)),
                         (Color.adaLightBlue.opacity(0.4))]),
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
                                    Color.adaLightBlue,
                                    Color.adaLightBlue,
                                    (Color.adaLightBlue.opacity(0))]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing))
                        )
            }
            .background(
                .linearGradient(.init(
                    colors: [(Color.adaLightBlue.opacity(0)),
                             (Color.adaLightBlue.opacity(0.2)),
                             (Color.adaLightBlue.opacity(0.4))]),
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
            .background(Color.adaLightBlue)
            .clipShape(Circle())
        }
        
    }
}
