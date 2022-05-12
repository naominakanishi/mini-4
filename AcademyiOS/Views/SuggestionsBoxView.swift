import SwiftUI

struct SuggestionsBoxView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            Spacer()
            
            Text("To do")
                .foregroundColor(Color.white)
            
            Spacer()
        }
        .background(Color.adaBackground)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct SuggestionsBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsBoxView()
    }
}
