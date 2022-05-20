import SwiftUI

struct SuggestionsBoxView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = SuggestionsBoxViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Deixe aqui sua sugestão ou crítica para melhorar o ambiente da Academy.\nLembre-se que sua resposta será anônima, e poderá ser acessada somente pelo Binder :)")
                    .bold()
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .padding(.bottom, 20)
                TextField("Deixe aqui sua sugestão ou crítica para melhorar o ambiente da Academy", text: $viewModel.text)
                    .padding()
                    .background(Color.adaDarkGray)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.10), radius: 16, x: 0, y: 0)
                    .foregroundColor(Color.white)
                
                Spacer()
            }
            
            VStack {
                Spacer()
                
                Button(action: {
                    viewModel.sendSuggestion()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    VStack {
                        Text("Enviar")
                            .bold()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.adaLightBlue)
                .cornerRadius(8)
                .foregroundColor(.white)
            }
        }
        .padding(.horizontal)
        .background(Color.adaBackground)
        .navigationBarBackButtonHidden(true)
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
        .navigationTitle("Caixinha de sugestões")
    }
}

struct SuggestionsBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsBoxView()
    }
}
