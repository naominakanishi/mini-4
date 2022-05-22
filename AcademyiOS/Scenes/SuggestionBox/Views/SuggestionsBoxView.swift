import SwiftUI
import AcademyUI

struct SuggestionsBoxView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = SuggestionsBoxViewModel()
    
    @FocusState
    private(set) var isEditingDescription: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Text("Deixe aqui sua sugestão ou crítica para melhorar o ambiente da Academy.\nLembre-se que sua resposta será anônima, e poderá ser acessada somente pelo Binder :)")
                    .bold()
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .padding(.bottom, 20)
                GrowableTextField(hint: "Deixe aqui sua sugestão ou crítica para melhorar o ambiente da Academy",
                                  text: $viewModel.text,
                                  isEditingDescription: _isEditingDescription
                )
                .frame(maxHeight: 200)
                .padding()
                .background(Color.white.textFieldAdaGradient())
                .cornerRadius(8)
                .shadow(color: .black.opacity(0.10), radius: 16, x: 0, y: 0)
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
        .onTapGesture {
            if isEditingDescription {
                isEditingDescription = false
            }
        }
    }
}

struct SuggestionsBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsBoxView()
    }
}
