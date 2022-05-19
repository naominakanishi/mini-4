import SwiftUI

struct Loader: View {
    @State private var isRotated = false
    
    var animation: Animation {
        Animation.easeInOut
            .repeatForever(autoreverses: true)
    }
    
    var body: some View {
        VStack {
            Text("🍎")
                .font(.system(size: 60, weight: .regular, design: .default))
                .rotationEffect(Angle.degrees(isRotated ? 360 : 0))
                .animation(animation.speed(0.2), value: isRotated)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color.adaBackground)
        .onAppear {
            isRotated = true
        }
    }
}

struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        Loader()
    }
}
