import SwiftUI
import Academy
import AcademyUI

struct AnnouncementListView: View {
    @ObservedObject var viewModel: AnnouncementListViewModel
    
    @EnvironmentObject var authService: AuthService
    
    @State private var modal = false
    
    init(viewModel: AnnouncementListViewModel) {
        self.viewModel = viewModel
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
    
    var body: some View {
        List {
            ForEach (viewModel.announcementList, id: \.id) { announcement in
                AnnouncementCard(
                    text: announcement.text,
                    user: announcement.fromUser,
                    dateString: announcement.createdDate.getFormattedDate()
                )
                .onLongPressGesture {
                    modal = true
                }
            }
        }
        .background(Color.adaBackground)
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    modal = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $modal) {
            AnnouncementFormView(viewModel: .init(currentUser: authService.user, sender: .init()))
        }
    }
    
  
}

struct AnnouncementListView_Preview: PreviewProvider {
    static var previews: some View {
        AnnouncementListView(viewModel: AnnouncementListViewModel(listener: AnnouncementListenerService()))
    }
}
