import SwiftUI
import Academy
import AcademyUI

struct HelpListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var authService: AuthService
    @ObservedObject private var viewModel: HelpListViewModel
    
    init(currentUser: AcademyUser) {
        self.viewModel = HelpListViewModel(
            currentUser: currentUser,
            listener: HelpListenerService(),
            helpAssignService: HelpAssignService(),
            helpUpdatingService: HelpUpdatingService()
        )
    }
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.filterTags) { tag in
                                    AcademyTag(text: tag.name,
                                               color: tag.color,
                                               isSelected: tag.isSelected)
                                    .onTapGesture {
                                        viewModel.didSelectFilter(withId: tag.id)
                                    }
                                }
                                Spacer()
                            }
                        }
                        .padding(.leading)
                        .padding(.bottom)
                        
                        ForEach(viewModel.currentHelpList) { helpModel in
                            HelpCard(
                                queuePosition: viewModel.getQueuePosition(help: helpModel),
                                isFromUser: helpModel.user.id == authService.user.id,
                                helpModel: helpModel,
                                assignHelpHandler: {
                                    viewModel.assignHelpHandler(help: helpModel)
                                },
                                completeHelpHandler: {
                                    viewModel.completeHelpHandler(help: helpModel)
                                }
                            )
                            .onLongPressGesture {
                                if helpModel.user.id == authService.user.id {
                                    viewModel.handleCardLongPress(helpModel: helpModel)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
            
            VStack {
                Spacer()
                
                HStack(alignment: .bottom) {
                    Spacer()
                    
                    Button(action: {
                        viewModel.showRequestHelpModal = true
                    }) {
                        ZStack {
                            Circle()
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.title)
                        }
                        .frame(maxWidth: 60, maxHeight: 60)
                        .padding()
                    }
                }
            }
        }
        .background(Color.adaBackground)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $viewModel.showRequestHelpModal) {
            HelpFormView(user: authService.user, helpModel: viewModel.helpOnEdit ?? nil) {
                viewModel.helpOnEdit = nil
            }
        }
        .onAppear {
            viewModel.handleOnAppear()
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                }
            }
        })
        .navigationTitle("Fila de ajuda")
    }
}


//struct HelpListView_Previews: PreviewProvider {
//    static var previews: some View {
//        HelpListView()
//    }
//}
