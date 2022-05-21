import SwiftUI
import Academy
import AcademyUI

struct HelpListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var viewModel: HelpListViewModel
    
    init() {
        self.viewModel = HelpListViewModel(
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
                                queuePosition: helpModel.queuePosition,
                                isFromUser: helpModel.isOwner,
                                helpModel: helpModel.help,
                                assignHelpHandler: {
                                    viewModel.assignHelpHandler(help: helpModel.help)
                                },
                                completeHelpHandler: {
                                    viewModel.completeHelpHandler(help: helpModel.help)
                                }
                            )
                            .onLongPressGesture {
                                if helpModel.isOwner {
                                    viewModel.handleCardLongPress(helpModel: helpModel.help)
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
            HelpFormView(helpModel: viewModel.helpOnEdit ?? nil) {
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
