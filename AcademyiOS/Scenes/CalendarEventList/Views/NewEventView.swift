import SwiftUI
import AcademyUI

struct NewEventView: View {
    @StateObject
    var viewModel: NewEventViewModel = .init()
    
    @FocusState
    private var isEditing: Bool
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Novo evento")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                .padding(.top, 16)
                
                GrowableTextField(hint: "Título",
                                  text: $viewModel.title,
                                  isEditingDescription: _isEditing)
                .textContentType(.username)
                .padding(8)
                .background(Color.white.opacity(0.1).adaGradient(repeatCount: 3))
                .cornerRadius(8)
                .frame(maxHeight: 50)
                
                
                SingleEmojiTextField(text: $viewModel.emoji)
                    .padding(8)
                    .background(Color.white.opacity(0.1).adaGradient(repeatCount: 3))
                    .cornerRadius(8)
                    .frame(maxHeight: 50)
                
                durationPicker
                
                DropdownPicker(options: viewModel.frequencyOptions,
                               title: "Repete",
                               leadingIconName: "",
                               selectedOption: $viewModel.repeatingFrequency)
                .padding(.vertical, 16)
                .padding(.horizontal, 8)
                .background(Color.white.opacity(0.1).adaGradient(repeatCount: 3))
                .cornerRadius(12)
                Spacer()
            }
            .padding(.horizontal, DesignSystem.Spacing.generalHPadding / 2)
            VStack {
                Spacer()
                saveButton
            }
        }
        .background(Color.adaBackground)
        .onTapGesture {
            isEditing = false
        }
    }
    
    @ViewBuilder
    private var durationPicker: some View {
        VStack {
            HStack {
                Toggle("  Dia inteiro", isOn: $viewModel.isAllDay)
                    .font(.adaTagTitle)
                    .padding(8)
                    .background(Color.white.opacity(0.1).adaGradient(repeatCount: 3))
                    .cornerRadius(8)
                    .frame(maxHeight: 50)
            }
            
            DatePicker(selection: $viewModel.startDate, displayedComponents: viewModel.availableDateComponents) {
                Text("Começa")
                    .font(.adaTagTitle)
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(Color.white.opacity(0.1).adaGradient(repeatCount: 3))
            .cornerRadius(12)
            
            DatePicker(selection: $viewModel.endDate, displayedComponents: viewModel.availableDateComponents) {
                Text("Termina")
                    .font(.adaTagTitle)
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(Color.white.opacity(0.1).adaGradient(repeatCount: 3))
            .cornerRadius(12)
            
        }
    }
    
    @ViewBuilder
    private var saveButton: some View {
        
        Button {
            
        } label: {
            Text("Enviar")
                .bold()
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background(Color.adaLightBlue)
                .cornerRadius(8)
                .foregroundColor(.white)
        }
//        .disabled(viewModel.isButtonDisabled)
        .padding(.horizontal)
    }
}
