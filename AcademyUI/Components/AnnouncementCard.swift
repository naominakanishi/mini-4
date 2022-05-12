import SwiftUI
import Academy

public struct AnnouncementCard: View {
    var announcement: Announcement
    
    public init(announcement: Announcement) {
        self.announcement = announcement
    }
    
    public var body: some View {
        HStack(alignment: .top) {
            Image(announcement.fromUser.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 100, maxHeight: 100)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("@" + announcement.fromUser.name)
                        .bold()
                        .font(.system(size: 30, weight: .bold, design: .default))
                    Spacer()
                    Text(announcement.date.getFormattedDate())
                        .font(.system(size: 21, weight: .regular, design: .default))
                }
                .padding(.bottom, 4)
                
                Text(announcement.text)
                    .font(.system(size: 24, weight: .regular, design: .default))
            }
        }
        .padding(32)
        .background()
        .foregroundColor(.white)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.1), radius: 16, x: 0, y: 0)
    }
}

struct AnnouncementCard_Previews: PreviewProvider {
    static var previews: some View {
        AnnouncementCard(announcement: Announcement(fromUser: User(name: "André", imageName: "andre-memoji"), date: Date(), text: "Hoje não teremos Get Together kjkds dskdsakn askn dskadkn sndska askn asn asnsd aknsa sakn asknsadkdn skndsn sndndskan sknsda ksksksksk sksansak sn kanks kanskns akndkan aksnsak!!!!!! ", isActive: true))
    }
}
