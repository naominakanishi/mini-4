import SwiftUI
import AcademyUI

struct EquipmentListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = EquipmentListViewModel(listener: .init())
    
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
            
            HStack {
                Text("Equipamentos")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.white)
                
                Spacer()
            }
            .padding(.vertical)
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    EquipmentTypeFilterButton(equipmentType: .all) {
                        viewModel.filterChosen = .all
                    }
                    .padding(.leading)
                    
                    EquipmentTypeFilterButton(equipmentType: .iPad) {
                        viewModel.filterChosen = .iPad
                    }
                    
                    EquipmentTypeFilterButton(equipmentType: .pencil) {
                        viewModel.filterChosen = .pencil
                    }
                    
                    EquipmentTypeFilterButton(equipmentType: .mac) {
                        viewModel.filterChosen = .mac
                    }
                    
                    EquipmentTypeFilterButton(equipmentType: .watch) {
                        viewModel.filterChosen = .watch
                    }
                    .padding(.trailing)
                    
                    Spacer()
                }
            }
            .padding(.bottom)
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.equipmentList) { equipment in
                    EquipmentCard(equipment: equipment)
                        .padding(.horizontal, 1)
                }
            }
            .padding(.horizontal)
            
        }
        .padding(.vertical)
        .background(Color.adaBackground)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.handleOnAppear()
        }
    }
}

struct EquipmentListView_Previews: PreviewProvider {
    static var previews: some View {
        EquipmentListView()
    }
}
