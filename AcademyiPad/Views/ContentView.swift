import SwiftUI
import Academy
import AcademyUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Ajuda Progs")
                        .font(.title2)
                        .bold()
                    ForEach(viewModel.codeHelpList, id: \.self) { helpModel in
                        HelpCard(helpModel: helpModel)
                    }
                    Spacer()
                }
                .padding()
                
                VStack {
                    Text("Ajuda Design")
                        .font(.title2)
                        .bold()
                    ForEach(viewModel.designHelpList, id: \.self) { helpModel in
                        HelpCard(helpModel: helpModel)
                    }
                    Spacer()
                }
                .padding()
                
                VStack {
                    Text("Ajuda Business")
                        .font(.title2)
                        .bold()
                    ForEach(viewModel.businessHelpList, id: \.self) { helpModel in
                        HelpCard(helpModel: helpModel)
                    }
                    Spacer()
                }
                .padding()
            }
            
            Spacer()
        }
        .statusBar(hidden: true)
        .padding()
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
