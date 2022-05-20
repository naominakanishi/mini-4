import SwiftUI
import Academy
import AcademyUI

struct AnnouncementListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
        Group {
            if viewModel.announcementList.isEmpty {
                VStack {
                    VStack {
                        Text("Nenhum aviso importante hoje... 😴")
                            .padding()
                            .foregroundColor(Color.white)
                            .font(.system(size: 16, weight: .regular, design: .default))
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.adaDarkGray)
                    .cornerRadius(8)
                    Spacer()
                }
                .background(Color.adaBackground)
            } else {
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
            }
        }
        .navigationTitle("Avisos")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                }
            }
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
