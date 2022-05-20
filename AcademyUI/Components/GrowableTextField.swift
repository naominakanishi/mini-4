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
    
    public var body: some View {
        TextEditor(text: $text)
            .focused($isEditingDescription)
    }
}
