import SwiftUI
import Academy
import AcademyUI

struct RequestHelpModalView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var categoryChosen: HelpType? = nil
    @State var subject: String = ""
    @State var description: String = ""
    @State var location: String = ""
    
    var body: some View {
        VStack {
            Text("Precisa de ajuda?")
                .bold()
                .font(.title2)
                .padding(.vertical, 32)
                .foregroundColor(Color.white)
            
            VStack(alignment: .leading) {
                    Text("Categoria")
                        .bold()
                        .foregroundColor(Color.white)
                    
                    HStack {
                        HelpTypeFilterButton(helpType: .code) {
                            categoryChosen = .code
                        }
                        
                        HelpTypeFilterButton(helpType: .design) {
                            categoryChosen = .design
                        }
                        
                        HelpTypeFilterButton(helpType: .business) {
                            categoryChosen = .business
                        }
                    
                    Spacer()
                }
                
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text("Assunto principal")
                    .bold()
                    .foregroundColor(Color.white)
                
                TextField("Seu desafio em poucas palavras", text: $subject)
                    .padding()
                    .background(Color.adaDarkGray)
                    .foregroundColor(Color.white)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.10), radius: 16, x: 0, y: 0)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text("Descrição")
                    .bold()
                    .foregroundColor(Color.white)
                
                TextField("Descreva com mais detalhes o que você está tentando fazer e o que você já tentou até aogra", text: $description)
                    .padding()
                    .frame(height: 150)
                    .background(Color.adaDarkGray)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.10), radius: 16, x: 0, y: 0)
                    .foregroundColor(Color.white)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text("Onde você está?")
                    .bold()
                    .foregroundColor(Color.white)
                
                TextField("Onde a ajuda poderá te encontrar", text: $location)
                    .padding()
                    .background(Color.adaDarkGray)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.10), radius: 16, x: 0, y: 0)
                    .foregroundColor(Color.white)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            Button(action: {
                print("Save new help request on Firebase Database")
                presentationMode.wrappedValue.dismiss()
            }) {
                VStack {
                    Text("Pedir ajuda")
                        .foregroundColor(.white)
                        .bold()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(30)
                .padding()
            }
            
            Spacer()
        }
        .background(Color.adaBackground)
    }
}

struct RequestHelpModalView_Previews: PreviewProvider {
    static var previews: some View {
        RequestHelpModalView()
    }
}
