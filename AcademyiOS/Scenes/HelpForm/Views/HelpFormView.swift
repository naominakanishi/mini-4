import SwiftUI
import Academy
import AcademyUI

struct HelpFormView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: HelpFormViewModel
    var onDismiss: () -> ()
    
    @FocusState
    private var isEditingHeadline: Bool
    
    @FocusState
    private var isEditingContent: Bool
    
    @FocusState private var isEditingLocation: Bool
    
    init(user: AcademyUser, helpModel: Help?, onDismiss: @escaping () -> ()) {
        self.onDismiss = onDismiss
        self.viewModel = HelpFormViewModel(helpModel: helpModel, user: user)
    }
    
    var body: some View {
        VStack {
            titleView
                .padding(.vertical, DesignSystem.Spacing.titleToContentPadding)
            Group {
                helpTypePickerView
                headlineTextField
                contentTextField
                locationTextField
            }
            .padding(.vertical, DesignSystem.Spacing.cardInternalPadding)
            
            
            Spacer()
            
            Button {
                presentationMode.wrappedValue.dismiss()
                viewModel.tapButtonHandle()
            } label: {
                Text("Enviar")
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background(Color.adaLightBlue)
                    .cornerRadius(8)
                    .foregroundColor(.white)
            }
            .disabled(viewModel.isButtonDisabled)
        }
        .padding(.horizontal, DesignSystem.Spacing.generalHPadding)
        .background(Color.adaBackground)
        .onTapGesture {
            if(isEditingHeadline) {
                isEditingHeadline = false
            }
            
            if(isEditingContent) {
                isEditingContent = false
            }
            
            if(isEditingLocation) {
                isEditingLocation = false
            }
        }
    }
    
    @ViewBuilder
    private var titleView: some View {
        HStack {
            Text("Precisa de ajuda?")
                .font(.largeTitle)
                .bold()
            Spacer()
        }
    }
    
    @ViewBuilder private var helpTypePickerView: some View {
        VStack(alignment: .leading) {
            Text("Com o que você precisa de ajuda?")
                .font(.adaFontSubtitle)

            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.tags) { tag in
                        AcademyTag(text: tag.name,
                                   color: tag.color,
                                   isSelected: tag.isSelected
                        )
                        .onTapGesture {
                            viewModel.didSelectTag(withId: tag.id)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder private var headlineTextField: some View {
        GrowableTextField(hint: "Escreva aqui um resumo da sua dúvida", text: $viewModel.title, isEditingDescription: _isEditingHeadline)
            .padding(4)
            .frame(maxHeight: 60)
            .background(Color.white.textFieldAdaGradient())
            .cornerRadius(12)
    }
    
    @ViewBuilder private var contentTextField: some View {
        GrowableTextField(hint: "Descreva aqui com mais detalhes com o que você precisa de ajuda", text: $viewModel.description, isEditingDescription: _isEditingContent)
            .padding(4)
            .frame(maxHeight: 200)
            .background(Color.white.textFieldAdaGradient())
            .cornerRadius(12)
    }
    
    @ViewBuilder private var locationTextField: some View {
        GrowableTextField(hint: "Onde você está?", text: $viewModel.currentLocation, isEditingDescription: _isEditingHeadline)
            .padding(4)
            .frame(maxHeight: 60)
            .background(Color.white.textFieldAdaGradient())
            .cornerRadius(12)
    }
    

}

//struct HelpFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        HelpFormView(helpModel: nil) {
//            print("")
//        }
//    }
//}
