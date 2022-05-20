//
//  ProfileView.swift
//  AcademyiOS
//
//  Created by HANNA P C FERREIRA on 17/05/22.
//

import SwiftUI
import AcademyUI

struct ProfileView: View {
    
    @ObservedObject var picViewModel: ProfilePictureViewModel
    @State var firstResponder: Int = 0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 30){
                ProfilePictureView(viewModel: picViewModel)
                
                CustomTextField(text: .constant("@hannapcf"), //TODO: Input de dados
                                firstResponder: .constant(1),
                                order: 1)
                .modifier(TextFieldModifier())
                
                VStack(alignment: .leading, spacing: 0){
                    HStack{
                        Image(systemName: "hands.sparkles.fill")
                            .foregroundColor(.adaLightBlue)
                        Text("Posso ajudar em")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                        Spacer()
                        HStack(alignment: .center, spacing: 9){
                            //TODO: HelpCards aqui, ver com o André
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.1))
                .cornerRadius(12)
                
                VStack{
                    HStack{
                        Image(systemName: "person.crop.square.filled.and.at.rectangle.fill")
                            .foregroundColor(.adaLightBlue)
                        Text("Seu cargo")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                        Spacer()
                        HStack(alignment: .center, spacing: 9){
                            //TODO: RolesCards aqui, ver com o André
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.1))
                .cornerRadius(12)
                
                GeneralButton(title: "Disponibilidade",
                              image: "calendar.badge.clock",
                              enabled: true,
                              borderColor: .clear,
                              hasOptions: false,
                              hasChevron: true,
                              hasSavedData: true,
                              savedData: "",
                              onTap: {})
                
                GeneralButton(title: "Aniversário",
                              image: "calendar",
                              enabled: true,
                              borderColor: .clear,
                              hasOptions: true,
                              hasChevron: false,
                              hasSavedData: true,
                              savedData: "01/01/2000",
                              onTap: {})
                Spacer()
                
                Button(action: {
                    //TODO: Button Action
                }, label: {
                    Text("Salvar")
                        .padding(14)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.adaLightBlue)
                        .cornerRadius(12)
                })
                .padding(.bottom, 51)
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.adaBackground)
            .edgesIgnoringSafeArea(.all)
        }
        .background(Color.adaBackground)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Perfil")
        .sheet(isPresented: $picViewModel.openCameraRoll){
            ImagePicker(selectedImage: $picViewModel.imageSelected,
                        sourceType: .photoLibrary)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(
            picViewModel: ProfilePictureViewModel(
                changePic: false,
                openCameraRoll: false,
                imageSelected: UIImage())
        )
        .preferredColorScheme(.dark)
    }
}

