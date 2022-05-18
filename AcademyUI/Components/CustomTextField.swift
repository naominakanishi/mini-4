//
//  TextField.swift
//  AcademyUI
//
//  Created by HANNA P C FERREIRA on 17/05/22.
//

import SwiftUI

struct CustomTextField: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var firstResponder: Int
    
    private var font: UIFont = .systemFont(ofSize: 14)
    private var keyboardType: UIKeyboardType = .default
    private var returnKeyType: UIReturnKeyType = .next
    private var textContentType: UITextContentType?
    
    private var alignment: NSTextAlignment = .natural
    private var isCurrency = false
    private var maxCurrencyValue: Decimal? = nil
    private var color: UIColor = .white
    
    private var inputView: UIView?
    private var placeholder: String?
    private var placeholderColor: UIColor = .white
    private var placeHolderFont: UIFont = .systemFont(ofSize: 14)
    
    private var mask: String?
    private var secure: Bool = false
    private var returnPressed: (() -> Void)?
    private var beginEdit: (() -> Void)?
    private var enabled: Bool = true
    private var order: Int = .max
    private var dismissButtonLabel: String?
    
    private let textField = UITextField(frame: .zero)
    
    init(text: Binding<String>, firstResponder: Binding<Int>, order: Int) {
        _text = text
        _firstResponder = firstResponder
        self.order = order
    }
    
    func makeUIView(context: Context) -> UITextField {
        textField.delegate = context.coordinator
        
        setupView(textField, context: context)
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        
        setupView(uiView, context: context)
        
        if firstResponder == order && enabled {
            DispatchQueue.main.async { //avoid attributed cycle issue
                uiView.becomeFirstResponder()
            }
        }
        
        if firstResponder == -1 {
            DispatchQueue.main.async {
                uiView.resignFirstResponder()
            }
            
        }
    }
    
    
    func setupView(_ view: UITextField, context: Context) {
        if let mask = mask {
            view.text = text.masked(mask)
        } else if isCurrency {
            view.text = (text.toDecimalValue()/100).currencyFormat()
        } else {
            view.text = text
        }
        view.textColor = color
        view.isEnabled = enabled
        view.placeholder = placeholder
        view.isSecureTextEntry = secure
        view.returnKeyType = returnKeyType
        view.textAlignment = alignment
        view.placeholder = placeholder
        view.font = font
        view.keyboardType = keyboardType
        if let textContentType = textContentType {
            view.textContentType = textContentType
        }
        
        if let placeholder = placeholder {
            view.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [
                    .foregroundColor: placeholderColor,
                    .font: placeHolderFont
                ]
            )
        }
        
        if let inputView = inputView {
            view.inputView = inputView
            view.tintColor = .clear //remove carat
        }
        
        textField.inputAccessoryView = toolbar(coordinator: context.coordinator)
        context.coordinator.mask = mask
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self, mask: mask, isCurrency: isCurrency, maxCurrencyValue: maxCurrencyValue)
    }
    
    func dismiss() {
        self.firstResponder = -1
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        private var parent: CustomTextField
        var mask: String?
        private var isCurrency: Bool
        private var maxCurrencyValue: Decimal?
        
        init(_ textField: CustomTextField, mask: String?, isCurrency: Bool, maxCurrencyValue: Decimal?) {
            self.parent = textField
            self.mask = mask
            self.isCurrency = isCurrency
            self.maxCurrencyValue = maxCurrencyValue
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            parent.text = textField.text ?? ""
            parent.returnPressed?()
            
            return true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            //let text = textField.text
            //DispatchQueue.main.async {
            //    self.parent.text = text ?? ""
            //    print("parent set to \(text ?? "nil")")
            //}
            
            
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            
            DispatchQueue.main.async {
                self.parent.firstResponder = self.parent.order
                self.parent.beginEdit?()
            }
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            if let currentText = textField.text,
               let convertedRange = Range(range, in: currentText) {
                
                var replaced = currentText.replacingCharacters(in: convertedRange, with: string)
            
                if let mask = mask {
                    replaced = replaced.masked(mask)
                } else if isCurrency {
                    var value = replaced.toDecimalValue()/100
                    if let max = maxCurrencyValue, value > max {
                        value = max
                    }
                    replaced = (value).currencyFormat()
                }
                
                textField.text = replaced
                parent.text = replaced
                
            }
            
            return false
            
        }
        
        @objc func endEditing() {
            self.parent.dismiss()
        }
    }
    
    func toolbar(coordinator: Coordinator) -> UIToolbar? {
        guard let title = dismissButtonLabel else {
            return nil
        }
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let button: UIBarButtonItem = UIBarButtonItem(title: title, style: .done, target: coordinator, action: #selector(Coordinator.endEditing))
        let items = [flexSpace, button]
        toolbar.items = items
        
        return toolbar
    }
}

extension CustomTextField {
    
    func foregroundColor(_ color: UIColor) -> CustomTextField {
        var view = self
        view.color = color
        return view
    }
    
    func mask(_ mask: String) -> CustomTextField {
        var view = self
        view.mask = mask
        return view
    }
    
    func isSecure(_ secure: Bool) -> CustomTextField {
        var view = self
        view.secure = secure
        return view
    }
    
    func font(_ font: UIFont) -> CustomTextField {
        var view = self
        view.font = font
        return view
    }
    
    func isEnabled(_ enabled: Bool) -> CustomTextField {
        var view = self
        view.enabled = enabled
        return view
    }
    
    func onReturnPressed(_ callback: @escaping () -> Void) -> CustomTextField {
        var view = self
        view.returnPressed = callback
        return view
    }
    
    func onBeginEdit(_ callback: @escaping () -> Void) -> CustomTextField {
        var view = self
        view.beginEdit = callback
        return view
    }
    
    func returnKeyType(_ type: UIReturnKeyType) -> CustomTextField {
        var view = self
        view.returnKeyType = type
        return view
    }
    
    func keyboardType(_ type: UIKeyboardType) -> CustomTextField {
        var view = self
        view.keyboardType = type
        return view
    }
    
    func textContentType(_ type: UITextContentType) -> CustomTextField {
        var view = self
        view.textContentType = type
        return view
    }
    
    func alignment(_ alignment: NSTextAlignment) -> CustomTextField {
        var view = self
        view.alignment = alignment
        return view
    }
    
    func isCurrency(_ isCurrency: Bool) -> CustomTextField {
        var view = self
        view.isCurrency = isCurrency
        return view
    }
    
    func maxCurrencyValue(_ maxValue: Decimal?) -> CustomTextField {
        var view = self
        view.maxCurrencyValue = maxValue
        return view
    }
    
    func inputView(_ inputView: UIView?) -> CustomTextField {
        var view = self
        view.inputView = inputView
        return view
    }
    
    func placeholder(text: String, color: UIColor = .white, font: UIFont = .systemFont(ofSize: 14)) -> CustomTextField {
        var view = self
        view.placeholder = text
        view.placeholderColor = color
        view.placeHolderFont = font
        return view
    }
    
    func dismissButtonLabel(_ label: String) -> CustomTextField {
        var view = self
        view.dismissButtonLabel = label
        return view
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant("OK"), firstResponder: .constant(0), order: 0)
    }
}
