import SwiftUI
import Academy
import AcademyUI

struct HelpListView: View {
    @StateObject private var viewModel = HelpListViewModel()
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    VStack {
                        HStack {
                            Text("Fila de ajuda")
                                .font(.title)
                                .bold()
                            
                            Spacer()
                        }
                        .padding()
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                HelpTypeFilterButton(helpType: .all) {
                                    viewModel.filterChosen = .all
                                }
                                
                                HelpTypeFilterButton(helpType: .code) {
                                    viewModel.filterChosen = .code
                                }
                                
                                HelpTypeFilterButton(helpType: .design) {
                                    viewModel.filterChosen = .design
                                }
                                
                                HelpTypeFilterButton(helpType: .business) {
                                    viewModel.filterChosen = .business
                                }
                                
                                Spacer()
                            }
                        }
                        .padding(.leading)
                        .padding(.bottom)
                        
                        ForEach(viewModel.currentHelpModelList, id: \.self) { helpModel in
                            HelpCard(helpModel: helpModel)
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
        .sheet(isPresented: $viewModel.showRequestHelpModal) {
            RequestHelpModalView()
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}


struct HelpListView_Previews: PreviewProvider {
    static var previews: some View {
        HelpListView()
    }
}
