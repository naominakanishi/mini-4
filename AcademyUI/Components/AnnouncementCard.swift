import SwiftUI
import Academy

public struct AnnouncementCard: View {
    var announcement: Announcement
    
    public init(announcement: Announcement) {
        self.announcement = announcement
    }
    
    public var body: some View {
        HStack(alignment: .top) {
            Image(announcement.fromUser?.imageName ?? "andre-memoji")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 60, maxHeight: 60)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("@" + (announcement.fromUser?.name ?? "André"))
                        .bold()
                        .font(.system(size: 16, weight: .bold, design: .default))
                    Spacer()
                    Text(announcement.createdDate.getFormattedDate())
                        .font(.system(size: 14, weight: .regular, design: .default))
                }
                .padding(.bottom, 4)
                
                Text(announcement.text)
                    .font(.system(size: 16, weight: .regular, design: .default))
            }
        }
        .foregroundColor(Color.white)
        .padding()
        .background(Color.adaDarkGray)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.1), radius: 16, x: 0, y: 0)
    }
}

struct AnnouncementCard_Previews: PreviewProvider {
    static var previews: some View {
        AnnouncementCard(announcement: Announcement(id: "x", createdTimeInterval: Date().timeIntervalSince1970, text: "Hoje não teremos Get Together kjkds dskdsakn askn dskadkn sndska askn asn asnsd aknsa sakn asknsadkdn skndsn sndndskan sknsda ksksksksk sksansak sn kanks kanskns akndkan aksnsak!!!!!! ", isActive: true))
    }
}
