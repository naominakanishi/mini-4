import SwiftUI

struct AnnouncementFormView: View {
    @StateObject
    var viewModel: AnnouncementFormViewModel
    
    var body: some View {
        VStack {
            TextField("Escreva aqui o resumo", text: $viewModel.content)
            Button("Enviar") {
                viewModel.handleSend()
            }
            .disabled(viewModel.isButtonDisabled)
        }
    }
}
