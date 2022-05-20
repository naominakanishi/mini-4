import SwiftUI
import AcademyUI

struct AnnouncementFormView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject
    var viewModel: AnnouncementFormViewModel
    
    @FocusState
    private var isEditingHeadline: Bool
    
    @FocusState
    private var isEditingContent: Bool
    
    var body: some View {
        VStack {
            titleView
                .padding()
            announcementTypePickerView
                .padding(.horizontal)
            headlineTextField
            contentTextField
            Spacer()
            
            VStack {
                Text("Enviar")
                    .bold()
            }
            .frame(maxWidth: .infinity, maxHeight: 60)
            .background(Color.adaLightBlue)
            .cornerRadius(8)
            .foregroundColor(.white)
            .padding()
            .onTapGesture {
                viewModel.handleSend()
                presentationMode.wrappedValue.dismiss()
            }
        }
        .background(Color.adaBackground)
        .onTapGesture {
            if(isEditingHeadline) {
                isEditingHeadline = false
            }
            
            if(isEditingContent) {
                isEditingContent = false
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
                .font(.system(size: 14, weight: .bold))
                .padding([.horizontal, .top], 12)
            HStack {
                AcademyTag(text: "Aviso", color: .red)
                AcademyTag(text: "Entrega", color: .blue)
                Spacer()
            }
            .padding([.horizontal], 12)
        }
        .background(Color.white.opacity(0.08).textFieldAdaGradient(repeatCount: 1))
        .cornerRadius(12)
    }
    
    @ViewBuilder
    private var headlineTextField: some View {
        GrowableTextField(hint: "Escreva aqui um resumo do aviso para o preview (máx 100 caracteres) ",
                          text: $viewModel.headline,
                          isEditingDescription: _isEditingHeadline)
        .padding(4)
        .frame(maxHeight: 60)
        .cornerRadius(12)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private var contentTextField: some View {
        GrowableTextField(hint: "Escreva aqui o aviso",
                          text: $viewModel.content,
                          isEditingDescription: _isEditingContent)
        .padding(4)
        .frame(maxHeight: 200)
        .background(Color.white.opacity(0.1).textFieldAdaGradient(repeatCount: 4))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
