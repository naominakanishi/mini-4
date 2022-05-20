import SwiftUI
import AcademyUI

struct AnnouncementFormView: View {
    @StateObject
    var viewModel: AnnouncementFormViewModel
    
    @FocusState
    private var isEditing: Bool
    
    var body: some View {
        VStack {
            titleView
                .padding()
            announcementTypePickerView
                .padding()
            headlineTextField
            contentTextField
            Button("Enviar") {
                viewModel.handleSend()
            }
            .disabled(viewModel.isButtonDisabled)
        }
        .background(Color.adaBackground)
        .onTapGesture {
            if(isEditing) {
                isEditing = false
            }
        }
    }
    
    @ViewBuilder
    private var titleView: some View {
        HStack {
            Text("Novo aviso")
                .font(.largeTitle)
                .bold()
            Spacer()
        }
    }
    
    @ViewBuilder
    private var announcementTypePickerView: some View {
        VStack(alignment: .leading) {
            Text("Aviso ou entrega?")
                .bold()
                .padding([.horizontal, .top], 12)
            HStack {
                AcademyTag(text: "Aviso", color: .red)
                AcademyTag(text: "Entrega", color: .blue)
                Spacer()
            }
            .padding([.horizontal, .bottom], 12)
        }
        .background(Color.white.opacity(0.08).adaGradient(repeatCount: 5))
        .cornerRadius(12)
    }
    
    @ViewBuilder
    private var headlineTextField: some View {
        VStack {
            Text("Escreva aqui um resumo do aviso para o preview (máx 100 caracteres)")
            GrowableTextField(hint: "Escreva aqui um resumo do aviso para o preview (máx 100 caracteres) ",
                              text: $viewModel.headline,
                              isEditingDescription: _isEditing)
            .frame(maxHeight: 200)
        }
    }
    
    @ViewBuilder
    private var contentTextField: some View {
        VStack {
            Text("Escreva aqui o aviso")
            GrowableTextField(hint: "Escreva aqui o aviso",
                              text: $viewModel.content,
                              isEditingDescription: _isEditing)
            .frame(maxHeight: 200)
        }
    }
}
