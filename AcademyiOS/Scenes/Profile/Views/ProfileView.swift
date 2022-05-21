//
//  ProfileView.swift
//  AcademyiOS
//
//  Created by HANNA P C FERREIRA on 17/05/22.
//

import SwiftUI
import AcademyUI
import Combine

struct ProfileView: View {
    
    @StateObject var viewModel: ProfileViewModel = .init()
    
    @State
    private var openCameraRoll: Bool = false
    @State
    private var imageSelected: UIImage?
    
    @FocusState
    private var isEditing: Bool
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 30){
            imagePicker
            nameTextField
            abilitiesTags
            rolesDropdown
            birthdayPicker
            Spacer()
            saveButton
        }
            .padding()
            .background(Color.adaBackground)
            .navigationBarHidden(true)
            .onTapGesture {
                isEditing = false
            }
            .background(Color.adaBackground)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Perfil")
            .sheet(isPresented: $openCameraRoll){
                ImagePicker(selectedImage: $imageSelected,
                            sourceType: .photoLibrary)
            }
    }
    
    @ViewBuilder
    private var imagePicker: some View {
        Button {
            openCameraRoll = true
        } label: {
            ProfilePictureView(imageSelected: $imageSelected)
        }
    }
    
    @ViewBuilder
    private var birthdayPicker: some View {
        DatePicker(selection: $viewModel.birthday, displayedComponents: .date) {
            Label {
                Text("Aniversário")
                    .font(.adaTagTitle)
            } icon: {
                Image(systemName: "calendar")
                    .foregroundColor(Color.adaLightBlue)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(Color.white.opacity(0.1).adaGradient(repeatCount: 3))
        .cornerRadius(12)
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
                    ForEach(viewModel.helpTags) { tag in
                        AcademyTag(model: tag)
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
    private var nameTextField: some View {
        GrowableTextField(hint: "Seu nome",
                          text: $viewModel.displayName,
                          isEditingDescription: _isEditing)
            .padding(8)
            .background(Color.white.opacity(0.1).adaGradient(repeatCount: 3))
            .cornerRadius(8)
            .frame(maxHeight: 50)
    }
    
    @ViewBuilder
    private var rolesDropdown: some View {
        VStack {
            HStack{
                DropdownPicker(options: viewModel.availableRoles,
                               title: "Seu cargo",
                               leadingIconName: "person.crop.square.filled.and.at.rectangle.fill",
                               selectedOption: $viewModel.currentRole)
                Spacer()
                HStack(alignment: .center, spacing: 9){
                    //TODO: RolesCards aqui, ver com o André
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.1).adaGradient(repeatCount: 3))
        .cornerRadius(12)
    }
    
    @ViewBuilder
    private var saveButton: some View {
        Button(action: {
            //TODO: Button Action
        }, label: {
            Text("Salvar")
                .font(.adaTagTitle)
                .padding(14)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .background(Color.adaLightBlue)
                .cornerRadius(12)
        })
    }
}

struct DropdownPicker: View {
    let options: [String]
    let title: String
    let leadingIconName: String
    
    @Binding
    var selectedOption: String?
    
    @State
    private var isOpen = false
    
    var body: some View {
        VStack {
            headerView
            if isOpen {
                optionsView
            }
        }
    }
    
    @ViewBuilder
    private var headerView: some View {
        Button {
            isOpen.toggle()
        } label: {
            HStack {
                Image(systemName: leadingIconName)
                    .foregroundColor(.adaLightBlue)
                Text(title)
                    .font(.adaTagTitle)
                
                Spacer()
                
                if let selectedOption = selectedOption {
                    Text(selectedOption)
                }
                if isOpen {
                    Image(systemName: "triangle.fill")
                        .resizable()
                        .frame(width: 8, height: 8)
                } else {
                    Image(systemName: "arrowtriangle.down.fill")
                        .resizable()
                        .frame(width: 8, height: 8)
                }
            }
        }
        .foregroundColor(.white)
    }
    
    @ViewBuilder
    private var optionsView: some View {
        VStack(alignment: .leading) {
            Divider()
            ForEach(options, id: \.self) { option in
                Text(option)
                    .onTapGesture {
                        selectedOption = option
                        isOpen = false
                    }
                    .padding(8)
            }
        }
    }
}
