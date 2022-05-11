import SwiftUI
import Academy
import AcademyUI

struct ContentView: View {
    
    @State var codeHelpList: [Help] = []
    @State var designHelpList: [Help] = []
    @State var businessHelpList: [Help] = []
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Ajuda Progs")
                        .font(.title2)
                        .bold()
                    ForEach(codeHelpList, id: \.self) { helpModel in
                        HelpCard(helpModel: helpModel)
                    }
                    Spacer()
                }
                .padding()
                
                VStack {
                    Text("Ajuda Design")
                        .font(.title2)
                        .bold()
                    ForEach(designHelpList, id: \.self) { helpModel in
                        HelpCard(helpModel: helpModel)
                    }
                    Spacer()
                }
                .padding()
                
                VStack {
                    Text("Ajuda Business")
                        .font(.title2)
                        .bold()
                    ForEach(businessHelpList, id: \.self) { helpModel in
                        HelpCard(helpModel: helpModel)
                    }
                    Spacer()
                }
                .padding()
            }
            
            Spacer()
        }
        .onAppear {
            separateList()
        }
        .statusBar(hidden: true)
        .padding()
    }
    
    func separateList() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
