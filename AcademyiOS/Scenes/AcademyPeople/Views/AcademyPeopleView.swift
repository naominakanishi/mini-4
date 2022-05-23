import SwiftUI
import Academy
import AcademyUI

struct AcademyPeopleView: View {
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    
    @StateObject
    var viewModel = PeopleViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            filterList
                .padding()
            ScrollView {
                LazyVGrid (columns: columns, spacing: 14 ) {
                    ForEach(viewModel.users) { user in
                        NavigationLink(destination: {
                            ProfileView(academyUser: user.user)
                        }, label: {
                            VStack(alignment: .center, spacing: 5){
                                ProfilePictureView(imageUrl: .constant(URL(string: user.imageName)), size: 70)
                                Text(user.name)
                                    .foregroundColor(.white) //TODO: Cor de acordo com cargo
                                    .font(.system(size: 11))
                            }
                            .padding(0)
                        })
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
                        AcademyTag(text: filter.roleName,
                                   color: filter.color,
                                   isSelected: filter.isSelected)
                    }
                }
            }
        }
    }
}
