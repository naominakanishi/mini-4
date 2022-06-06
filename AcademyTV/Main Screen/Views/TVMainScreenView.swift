import SwiftUI
import AcademyUI
import Academy

struct TVMainScreenView: View {
    @StateObject
    var viewModel: TVMainScreenViewModel = .init()
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                announcementsView
            }
            
            VStack {
                currentMomentView
                todayEvents
            }
            .padding(.bottom, 48)
        }
        .padding(32)
        .padding(.top, 48)
        .edgesIgnoringSafeArea(.all)
        .background(Color.adaBackground)
    }
    
    
    @ViewBuilder
    private var announcementsView: some View {
        ScrollView {
            ScrollViewReader { reader in
                ForEach(viewModel.activeAnnouncements) { announcement in
                    VStack {
                        AnnouncementCard(
                            text: announcement.headline ?? announcement.text.prefix(100) + "...",
                            user: announcement.fromUser,
                            dateString: announcement.createdDate.getFormattedDate(),
                            type: (announcement.type ?? .announcement).rawValue,
                            titleFont: .tvAnnouncementTitle,
                            contentFont: .tvAnnouncementContent
                        )
                        .id(announcement.id)
                    }
                }
                .onChange(of: viewModel.currentPresentedAnnouncementId) { newValue in
                    withAnimation {
                        reader.scrollTo(newValue)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var currentMomentView: some View {
        if viewModel.currentMomentEvents.count == 0 {
            EmptyView()
        }
        VStack(alignment: .leading) {
            Text("Momento Atual")
                .font(.tvAnnouncementTitle)
            ForEach(viewModel.currentMomentEvents, id: \.self) { eventName in
                HStack {
                    Text(eventName)
                        .font(.tvAnnouncementTitle)
                        .padding(24)
                    Spacer()
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.adaPurple.reversedAdaGradient(repeatCount: 4), lineWidth: 1)
                        
                )
                .background(Color.adaPurple.opacity(0.07))
                .cornerRadius(16)
            }
        }
        .padding(12 + 20)
        .overlay(GeometryReader { proxy in
                RoundedRectangle(cornerRadius: 20)
                .frame(width: 12, height: proxy.size.height)
                .foregroundColor(Color.adaPink)
        })
    }
    
    @ViewBuilder
    private var todayEvents: some View {
        if let day = viewModel.todayEvents {
            MonthView(month: day)
                .padding(12 + 20)
                .overlay(GeometryReader { proxy in
                        RoundedRectangle(cornerRadius: 20)
                        .frame(width: 12, height: proxy.size.height)
                        .foregroundColor(Color.adaRed)
                })
        }
    }
}
