import SwiftUI
import Academy
import AcademyUI

public struct AnnouncementCard: View {
    
    var text: String
    let user: AcademyUser
    let dateString: String
    let type: String
    
    public init(text: String, user: AcademyUser, dateString: String, type: String) {
        self.text = text
        self.user = user
        self.dateString = dateString
        self.type = type
    }
    
    public var body: some View {
        HStack(alignment: .top) {
            ProfilePictureView(imageUrl: .constant(URL(string: user.imageName)), size: 44, userRole: .constant(user.role!))
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
            Text("@" + type)
                .bold()
                .font(.system(size: 16, weight: .bold, design: .default))
            Text("@" + user.name)
                .bold()
                .font(.system(size: 16, weight: .bold, design: .default))
            Spacer()
            Text(dateString)
                .font(.system(size: 14, weight: .regular, design: .default))
        }
    }
}
