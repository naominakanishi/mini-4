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
            .fill(color.adaGradient())
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
    func adaGradient(repeatCount count: Int = 5) -> LinearGradient {
        .init(colors: .init(repeating: self, count: count) + [.clear],
              startPoint: .topLeading,
              endPoint: .bottomTrailing)
    }
}

extension Color {
    func reversedAdaGradient(repeatCount count: Int = 5) -> LinearGradient {
        .init(colors: [.clear] + .init(repeating: self, count: count),
              startPoint: .topLeading,
              endPoint: .bottomTrailing)
    }
}
