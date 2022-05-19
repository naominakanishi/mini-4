import SwiftUI

public struct PersonView: View {
    let userImage: Image
    let username: String
    let color: Color
    
    private var progressChart: some View {
        Circle()
            .stroke(style: .init(
                lineWidth: 5,
                lineCap: .round,
                lineJoin: .round
            ))
            .fill(color.adaGradient)
        }

    
    public var body: some View {
        VStack{
            ZStack{
                progressChart
                    
                userImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(7)
            }
            .frame(width: 65, height: 65)
            
            Text(username)

            
        }

//        
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(userImage: Image("andre-memoji"), username: "André", color: .red)
            .preferredColorScheme(.dark)
    }
}

extension Color {
    var adaGradient: LinearGradient {
        .init(colors: .init(repeating: self, count: 5) + [.clear],
              startPoint: .topLeading,
              endPoint: .bottomTrailing)
    }
}
