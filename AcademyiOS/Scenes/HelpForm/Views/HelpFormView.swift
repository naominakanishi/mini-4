import SwiftUI
import Academy
import AcademyUI

struct HelpFormView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = HelpFormViewModel()
    var onDismiss: () -> ()
    
    
    init(onDismiss: @escaping () -> ()) {
        self.onDismiss = onDismiss
    }
    
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
                            viewModel.categoryChosen = .code
                        }
                        
                        HelpTypeFilterButton(helpType: .design) {
                            viewModel.categoryChosen = .design
                        }
                        
                        HelpTypeFilterButton(helpType: .business) {
                            viewModel.categoryChosen = .business
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
                
                TextField("Seu desafio em poucas palavras", text: $viewModel.subject)
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
                
                TextField("Descreva com mais detalhes o que você está tentando fazer e o que você já tentou até aogra", text: $viewModel.description)
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
                
                TextField("Onde a ajuda poderá te encontrar", text: $viewModel.location)
                    .padding()
                    .background(Color.adaDarkGray)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.10), radius: 16, x: 0, y: 0)
                    .foregroundColor(Color.white)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
                viewModel.createNewHelp()
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
        .onDisappear {
            onDismiss()
        }
    }
}

struct HelpFormView_Previews: PreviewProvider {
    static var previews: some View {
        HelpFormView {
            print("")
        }
    }
}
