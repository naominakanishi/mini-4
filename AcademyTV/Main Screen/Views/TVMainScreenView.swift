import SwiftUI
import AcademyUI
import Academy

struct TVMainScreenView: View {
    @StateObject
    var viewModel: TVMainScreenViewModel = .init()
    
    var body: some View {
        HStack {
            VStack {
                Text("Avisos")
                    .font(.tvTitle)
                    .foregroundColor(Color.white)
                Spacer()
            }
            
            VStack {
                Text("momento atual")
                Spacer()
                Text("entregas")
            }
        }
        .background(Color.adaBackground)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
    }
    
    
    @ViewBuilder
    private var announcementsView: some View {
        VStack {
            ForEach(viewModel.activeAnnouncements) { announcement in
                VStack {
                    AnnouncementCard(
                        text: announcement.headline ?? announcement.text.prefix(100) + "...",
                        user: announcement.fromUser,
                        dateString: announcement.createdDate.getFormattedDate(),
                        type: (announcement.type ?? .announcement).rawValue,
                        titleFont: .tvAnnouncementTitle,
                        contentFont: .tvAnnouncementContent)
                    
                    Spacer()
                        .frame(height: 20)
                    
                }
                
            }
            
        }
    }
    
}
