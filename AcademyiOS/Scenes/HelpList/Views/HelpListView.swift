import SwiftUI
import Academy
import AcademyUI

struct HelpListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel = HelpListViewModel()
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    VStack {
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "arrow.left")
                                    .font(.system(size: 24, weight: .bold, design: .default))
                                    .foregroundColor(Color.white)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text("Fila de ajuda")
                                .font(.title)
                                .bold()
                                .foregroundColor(Color.white)
                            
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
                        
                        ForEach(viewModel.currentHelpList) { helpModel in
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
        .background(Color.adaBackground)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $viewModel.showRequestHelpModal) {
            HelpFormView {
                self.viewModel.readHelpList()
            }
        }
    }
}


struct HelpListView_Previews: PreviewProvider {
    static var previews: some View {
        HelpListView()
    }
}
