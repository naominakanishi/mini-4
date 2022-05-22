import SwiftUI
import Academy
import AcademyUI

struct AnnouncementListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var viewModel: AnnouncementListViewModel
    
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
                .padding(.horizontal, DesignSystem.Spacing.generalHPadding)
                .background(Color.adaBackground)
            
            } else {
                ScrollView {
                    VStack {
                        ForEach (viewModel.announcementList, id: \.id) { announcement in
                            AnnouncementCard(
                                text: announcement.announcement.text,
                                user: announcement.announcement.fromUser,
                                dateString: announcement.announcement.createdDate.getFormattedDate(),
                                type: (announcement.announcement.type ?? .announcement).rawValue
                            )
                            .onLongPressGesture {
                                modal = announcement.isOwner
                            }
                        }
                    }
                    .padding(.horizontal, DesignSystem.Spacing.generalHPadding / 2)
                    .padding(.top, DesignSystem.Spacing.titleToContentPadding)
                    
                    .background(Color.adaBackground)
                }
                
            }
            
        }
        
        
        .navigationTitle("Avisos")
            .padding(.bottom, DesignSystem.Spacing.titleToContentPadding)
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
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                }
            }
        }
        .background(Color.adaBackground)
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
