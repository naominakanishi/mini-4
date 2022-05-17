import SwiftUI

public struct PersonView: View {
    let userImage: Image
    let username: String
    
    public var body: some View {
        HStack {
            ZStack {
                Circle()
                    .foregroundColor(Color.adaGreen)
                userImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 65, height: 65)
            Text(username)
        }
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(userImage: Image("andre-memoji"), username: "André")
            .preferredColorScheme(.dark)
    }
}
