import SwiftUI

struct AcademyPeopleView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            HStack{
                PersonView(userImage: Image("andre-memoji"), username: "teste")
                Spacer()
                PersonView(userImage: Image("andre-memoji"), username: "teste")
                Spacer()
                PersonView(userImage: Image("andre-memoji"), username: "teste")
                Spacer()
                PersonView(userImage: Image("andre-memoji"), username: "teste")

            }
            .padding()
            
            HStack{
                PersonView(userImage: Image("andre-memoji"), username: "teste")
                Spacer()
                PersonView(userImage: Image("andre-memoji"), username: "teste")
                Spacer()
                PersonView(userImage: Image("andre-memoji"), username: "teste")
                Spacer()
                PersonView(userImage: Image("andre-memoji"), username: "teste")

            }
            .padding()
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.adaBackground)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button("<", action: {
            presentationMode.wrappedValue.dismiss()
        }))
        .navigationTitle("Avisos")
    }
}

struct AcademyPeopleView_Previews: PreviewProvider {
    static var previews: some View {
        AcademyPeopleView()
    }
}
