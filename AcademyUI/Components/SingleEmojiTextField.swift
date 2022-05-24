import SwiftUI

public struct SingleEmojiTextField: UIViewRepresentable {

    @Binding var text: String {
        willSet {
            guard newValue.count > 1
            else { return }
            
            let text = newValue
            guard let last = text.last
            else { return }
            
            guard last.isEmoji else {
                self.text.removeAll(where: { $0 == last })
                return
            }
            if self.text == String(last) {
                return
            }
            self.text = String(last)
            textField.text = self.text
        }
    }
    
    private let textField = _EmojiTextField()
    
    public init(text: Binding<String>) {
        self._text = text
    }

    public func makeCoordinator() -> TFCoordinator {
        TFCoordinator(self) {
            self.text = self.textField.text ?? ""
        }
    }
    
    public func makeUIView(context: UIViewRepresentableContext<SingleEmojiTextField>) -> UITextField {
        textField.delegate = context.coordinator
        textField.addTarget(context.coordinator,
                            action: #selector(context.coordinator.handleChange),
                            for: .editingChanged)
        textField.initalize()
        return textField
    }


    public func updateUIView(_ uiView: UITextField, context: Context) {}
}

public class TFCoordinator: NSObject, UITextFieldDelegate {
    var parent: SingleEmojiTextField
    let updateText: () -> Void

    init(_ textField: SingleEmojiTextField, updateText: @escaping () -> Void) {
        self.parent = textField
        self.updateText = updateText
    }
    
    @objc
    func handleChange() {
        updateText()
    }
}


class _EmojiTextField: UITextField {

    // required for iOS 13
    override var textInputContextIdentifier: String? { "" } // return non-nil to show the Emoji keyboard ¯\_(ツ)_/¯

    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                return mode
            }
        }
        return nil
    }
    
    func initalize() {
        
            let string = AttributedString("  Escolha um emoji 🍎", attributes: .init([
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 14, weight: .bold)
            ]))
        attributedPlaceholder =  NSAttributedString(string)
    }
}

extension Character {
    /// A simple emoji is one scalar and presented to the user as an Emoji
    private var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }

    /// Checks if the scalars will be merged into an emoji
    private var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }

    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}
