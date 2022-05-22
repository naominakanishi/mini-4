import SwiftUI
import Academy
import AcademyUI

struct AcademyPeopleView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject
    var viewModel = PeopleViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    //Mock
    
    var body: some View {
        VStack {
            filterList
                .padding()
            ScrollView {
                LazyVGrid (columns: columns, spacing: 14 ) {
                    ForEach(viewModel.users) { user in
                        PersonView(userImage: Image(user.imageName),
                                   username: user.name,
                                   color: user.color)
                    }
                }
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .foregroundColor(Color.white)
                    }
                }
            })
            .navigationTitle("Pessoas na Academy")
        }
        .background(Color.adaBackground)
    }
    
    private var filterList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.filterList) { filter in
                    Button {
                        viewModel.selectFilter(with: filter.id)
                    } label: {
                        AcademyTag(text: filter.roleName, color: filter.color, isSelected: true)
                    }
                }
            }
        }
    }
}

struct AcademyPeopleView_Previews: PreviewProvider {
    static var previews: some View {
        AcademyPeopleView()
    }
}
