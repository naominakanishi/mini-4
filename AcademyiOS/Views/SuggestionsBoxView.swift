import SwiftUI

struct SuggestionsBoxView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = SuggestionsBoxViewModel()
    
    var body: some View {
        ZStack {
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
                
                HStack {
                    Text("Caixinha de sugestões")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.white)
                    
                    Spacer()
                }
                .padding(.vertical)
                
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
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct SuggestionsBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsBoxView()
    }
}
