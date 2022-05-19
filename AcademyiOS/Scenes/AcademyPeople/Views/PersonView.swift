import SwiftUI

public struct PersonView: View {
    let userImage: Image
    let username: String
    
    private var progressChart: some View {
        Circle()
            .stroke(style: .init(
                lineWidth: 5,
                lineCap: .round,
                lineJoin: .round
            ))
            .fill(.linearGradient(.init(colors: [
                Color.adaGreen, Color.adaGreen, Color.adaGreen, Color.adaGreen, Color.clear
            ]), startPoint: .topLeading, endPoint: .bottomTrailing))
        }

    
    public var body: some View {
   //     progressChart
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
        PersonView(userImage: Image("andre-memoji"), username: "André")
            .preferredColorScheme(.dark)
    }
}
