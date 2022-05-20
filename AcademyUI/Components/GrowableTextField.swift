import SwiftUI

public struct GrowableTextField: View {
    public init(hint: String, text: Binding<String>, isEditingDescription: FocusState<Bool>) {
        self.hint = hint
        self._text = text
        self._isEditingDescription = isEditingDescription
        UITextView.appearance().backgroundColor = .clear
    }
    
    let hint: String
    
    @Binding
    var text: String
    
    @FocusState
    var isEditingDescription: Bool
    
    @State
    private var shouldDisplayHint = true
    
    @State
    private var shouldClearHint = true
    
    private var textProxy: Binding<String> {
        .init {
            text.isEmpty && shouldClearHint ? hint : text
        } set: { newValue in
            if newValue == hint {
                return
            }
            $text.wrappedValue = newValue
        }
    }
    
    public var body: some View {
        TextEditor(text: textProxy)
            .font(.system(size: 14, weight: .bold))
            .focused($isEditingDescription)
            .onChange(of: isEditingDescription) { isEditing in
                if(isEditing && shouldClearHint) {
                    textProxy.wrappedValue = ""
                    shouldClearHint = false
                }
                
                if(!isEditing && text.isEmpty) {
                    textProxy.wrappedValue = hint
                    shouldClearHint = true
                }
            }
            .onAppear {
                text = hint
            }
            .background(Color.white.opacity(0.1).textFieldAdaGradient(repeatCount: 4))
    }
}
