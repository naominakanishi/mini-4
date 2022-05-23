import SwiftUI
import Academy
import AcademyUI

struct ProfileView: View {
    
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    
    let academyUser: AcademyUser
    
    init(academyUser: AcademyUser) {
        self.academyUser = academyUser
    }
    
    
    var body: some View {
            ScrollView {
                VStack(alignment: .center, spacing: 12) {
                    profilePic
                        .padding(.bottom, 20)
                   // nameField
                    abilitiesTags
                    rolesField
                    birthdayField
                }
            }
            .padding(.horizontal, DesignSystem.Spacing.generalHPadding/2)
                .background(Color.adaBackground)
      
                .navigationTitle(academyUser.name) //todo
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .foregroundColor(Color.white)
                        }
                    }
                }
        
    }
    
    @ViewBuilder
    private var profilePic: some View {
        ProfilePictureView(imageUrl: .constant(.init(academyUser.imageName)), size: 90)
    }
    
    @ViewBuilder
    private var nameField: some View {
        HStack {
            Text("Nome da pessoa") // todo
                .font(.system(size: 14, weight: .bold))
                .padding(.horizontal, 8)
                .foregroundColor(.white)
                .padding(.vertical)

                
            Spacer()
        }
        .background(Color.white.opacity(0.6).textFieldAdaGradient())
        .cornerRadius(8)
        .frame(maxHeight: 50)
        
    }
    
    @ViewBuilder
    private var abilitiesTags: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack{
                Image(systemName: "hands.sparkles.fill")
                    .foregroundColor(.adaLightBlue)
                Text("Posso ajudar em")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                Spacer()
            }
            .padding()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(academyUser.helpTags ?? [], id: \.rawValue) { tag in
                        AcademyTag(model: .init(name: tag.rawValue,
                                                color: tag.color,
                                                isSelected: true))
                    }
                }
            }
            .padding([.bottom, .horizontal], 4)
        }
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.1).adaGradient(repeatCount: 3))
        .cornerRadius(12)
    }
    
    @ViewBuilder
    var rolesField: some View {
        HStack {
            Image(systemName: "person.crop.square.filled.and.at.rectangle.fill")
                .foregroundColor(.adaLightBlue)
                .padding(.leading)
            Text("Cargo")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.system(size: 14))
            Spacer()
            Text(academyUser.role?.rawValue ?? "")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.system(size: 14))
                .padding()
        }
        .background(Color.white.opacity(0.6).textFieldAdaGradient())
        .cornerRadius(8)
        .frame(maxHeight: 50)
        
    }
    
    @ViewBuilder
    var birthdayField: some View {
        HStack{
            Image(systemName: "calendar")
                .foregroundColor(.adaLightBlue)
                .padding(.leading)
            Text("Aniversário")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.system(size: 14))
            Spacer()
            if let birthday =  academyUser.birthday {
                let date = Date(timeIntervalSince1970: birthday).dayMonthYear
                Text(date) // todo
                    .padding(.horizontal, 8)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .font(.system(size: 14, weight: .semibold))
            }
        }
        .background(Color.white.opacity(0.6).textFieldAdaGradient())
        .cornerRadius(8)
        .frame(maxHeight: 50)
        
        
    }
}


