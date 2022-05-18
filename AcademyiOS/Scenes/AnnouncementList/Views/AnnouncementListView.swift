import SwiftUI
import Academy
import AcademyUI

struct AnnouncementListView: View {
    @ObservedObject
    var viewModel: AnnouncementListViewModel
    
    @State
    private var modal = false
    
    init(viewModel: AnnouncementListViewModel) {
        self.viewModel = viewModel
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
    
    var body: some View {
        List {
            ForEach (viewModel.announcementList, id: \.id) { announcement in
                AnnouncementCard(text: announcement.text,
                                 username: announcement.fromUser?.name ?? "Binder",
                                 time: announcement.createdDate.getFormattedDate(),
                                 userImage: Image("andre-memoji")
//                                 userImage: AsyncImage(url: announcement.fromUser?.imageName)
                )
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
            AnnouncementFormView(viewModel: .init(sender: .init()))
        }
    }
    
  
}

struct AnnouncementListView_Preview: PreviewProvider {
    static var previews: some View {
        AnnouncementListView(viewModel: AnnouncementListViewModel(listener: AnnouncementListenerService()))
    }
}
