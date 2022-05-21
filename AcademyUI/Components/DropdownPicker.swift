import SwiftUI

public struct DropdownPicker: View {
    public init(options: [String],
                title: String,
                leadingIconName: String,
                selectedOption: Binding<String?>) {
        self.options = options
        self.title = title
        self.leadingIconName = leadingIconName
        self._selectedOption = selectedOption
    }
    
    let options: [String]
    let title: String
    let leadingIconName: String
    
    @Binding
    public var selectedOption: String?
    
    @State
    private var isOpen = false
    
    public var body: some View {
        VStack {
            headerView
            if isOpen {
                optionsView
            }
        }
    }
    
    @ViewBuilder
    private var headerView: some View {
        Button {
            isOpen.toggle()
        } label: {
            HStack {
                Image(systemName: leadingIconName)
                    .foregroundColor(.adaLightBlue)
                Text(title)
                    .font(.adaTagTitle)
                
                Spacer()
                
                if let selectedOption = selectedOption {
                    Text(selectedOption)
                }
                if isOpen {
                    Image(systemName: "triangle.fill")
                        .resizable()
                        .frame(width: 8, height: 8)
                } else {
                    Image(systemName: "arrowtriangle.down.fill")
                        .resizable()
                        .frame(width: 8, height: 8)
                }
            }
        }
        .foregroundColor(.white)
    }
    
    @ViewBuilder
    private var optionsView: some View {
        VStack(alignment: .leading) {
            Divider()
            ForEach(options, id: \.self) { option in
                Text(option)
                    .onTapGesture {
                        selectedOption = option
                        isOpen = false
                    }
                    .padding(8)
            }
        }
    }
}
