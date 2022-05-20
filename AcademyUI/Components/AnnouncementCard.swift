import SwiftUI
import Academy

public struct AnnouncementCard: View {
    
    var text: String
    let user: AcademyUser
    let dateString: String
    
    public init(text: String, user: AcademyUser, dateString: String) {
        self.text = text
        self.user = user
        self.dateString = dateString
    }
    
    public var body: some View {
        HStack(alignment: .top) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.adaGreen)
                Image(user.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(maxWidth: 44, maxHeight: 44)
            
           announcementBody
        }
        .foregroundColor(Color.white)
        .padding()
        .background(Color.adaDarkGray)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.1), radius: 16, x: 0, y: 0)
        .listRowBackground(Color.adaBackground)
        .navigationTitle("Avisos")
    }
        

    
    private var announcementBody: some View {
        VStack(alignment: .leading) {
            announcementTitle
            Text(text)
        }
    }
    
    private var announcementTitle: some View {
        HStack {
            Text("@" + user.name)
                .bold()
                .font(.system(size: 16, weight: .bold, design: .default))
            Spacer()
            Text(dateString)
                .font(.system(size: 14, weight: .regular, design: .default))
        }
    }
}

//struct AnnouncementCard_Previews: PreviewProvider {
//    static var previews: some View {
//        AnnouncementCard(announcement: Announcement(id: "x", createdTimeInterval: Date().timeIntervalSince1970, text: "Hoje não teremos Get Together kjkds dskdsakn askn dskadkn sndska askn asn asnsd aknsa sakn asknsadkdn skndsn sndndskan sknsda ksksksksk sksansak sn kanks kanskns akndkan aksnsak!!!!!! ", isActive: true))
//    }
//}
