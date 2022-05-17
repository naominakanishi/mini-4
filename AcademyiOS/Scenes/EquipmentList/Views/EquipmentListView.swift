import SwiftUI
import AcademyUI

struct EquipmentListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = EquipmentListViewModel()
    
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
            
            HStack {
                Text("Equipamentos")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.white)
                
                Spacer()
            }
            .padding(.vertical)
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.equipmentList) { equipment in
                    EquipmentCard(equipment: equipment)
                        .padding(.horizontal, 1)
                }
            }
        }
        .padding()
        .background(Color.adaBackground)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct EquipmentListView_Previews: PreviewProvider {
    static var previews: some View {
        EquipmentListView()
    }
}
