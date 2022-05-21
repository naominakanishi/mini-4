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
    @StateObject var viewModel = HomeViewModel(
        announcementUpdatingService: .init(),
        announcementListenerService: .init()
    )
    
    @State var showHelpListView: Bool = false
    @State var showAcademyPeopleView: Bool = false
    @State var showEquipmentList: Bool = false
    @State var showSuggestionsBoxView: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 0){
                    HStack{
                        Text("Perfil")
                            .font(.system(size: 30, weight: .bold, design: .default))
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    
                    ProfilePictureView(viewModel: picViewModel)
                        .padding(.bottom, 25)
                    
                }
                .padding()
                
                Spacer()
                
                NavigationLink("", destination: HelpListView(), isActive: $showHelpListView)
                NavigationLink("", destination: AcademyPeopleView(), isActive: $showAcademyPeopleView)
                NavigationLink("", destination: EquipmentListView(), isActive: $showEquipmentList)
                NavigationLink("", destination: SuggestionsBoxView(), isActive: $showSuggestionsBoxView)
            }
            .padding(.horizontal, 23)
        }
        .background(Color.adaBackground)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
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

