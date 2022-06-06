import SwiftUI
import Academy
import AcademyUI

public struct AnnouncementCard: View {
    
    var text: String
    let user: AcademyUser
    let dateString: String
    let type: String
    let titleFont: Font
    let contentFont: Font
    
    public init(text: String, user: AcademyUser, dateString: String, type: String, titleFont: Font, contentFont: Font) {
        self.text = text
        self.user = user
        self.dateString = dateString
        self.type = type
        self.titleFont = titleFont
        self.contentFont = contentFont
    }
    
    public var body: some View {
        HStack(alignment: .top) {
            ProfilePictureView(
                imageUrl: .constant(URL(string: user.imageName)),
                size: imageSize,
                userRole: .constant(user.role!)
            )
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
                .font(contentFont)
        }
    }
    
    private var announcementTitle: some View {
        HStack {
            Text("@" + type)
                .bold()
                .font(titleFont)
            Text("@" + user.name)
                .bold()
                .font(titleFont)
            Spacer()
            Text(dateString)
                .font(contentFont)
        }
    }
    
    private var imageSize: CGFloat {
        #if os(tvOS)
            70
        #else
            44
        #endif
    }
}
