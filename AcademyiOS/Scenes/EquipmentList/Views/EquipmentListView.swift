import SwiftUI
import AcademyUI
import Academy

struct EquipmentListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var authService: AuthService
    @ObservedObject var viewModel: EquipmentListViewModel
    
    init(currentUser: AcademyUser) {
        self.viewModel = EquipmentListViewModel(currentUser: currentUser, listenerService: .init(), updatingService: .init(), waitlistService: .init())
    }
    
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
                    
                    EquipmentTypeFilterButton(equipmentType: .iPhone) {
                        viewModel.filterChosen = .iPhone
                    }
                    
                    EquipmentTypeFilterButton(equipmentType: .mac) {
                        viewModel.filterChosen = .mac
                    }
                    
                    EquipmentTypeFilterButton(equipmentType: .watch) {
                        viewModel.filterChosen = .watch
                    }
                    
                    EquipmentTypeFilterButton(equipmentType: .others) {
                        viewModel.filterChosen = .others
                    }
                    .padding(.trailing)
                    
                    Spacer()
                }
            }
            .padding(.bottom)
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.equipmentList) { equipment in
                    
                    EquipmentCard(isBorrowedByUser: (equipment.personWhoBorrowed?.id == authService.user.id), equipment: equipment) {
                        viewModel.handleTapOnEquipmentButton(equipment: equipment)
                    }
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

//struct EquipmentListView_Previews: PreviewProvider {
//    static var previews: some View {
//        EquipmentListView()
//    }
//}
