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
    
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    
    @ObservedObject
    var viewModel: ProfileViewModel
    
    @State
    private var openCameraRoll: Bool = false
    
    @FocusState
    private var isEditing: Bool
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .center, spacing: 30){
                    imagePicker
                    nameTextField
                    abilitiesTags
                    rolesDropdown
                    birthdayPicker
                    Spacer()
                }
            }
            
            Spacer()
            VStack {
                Spacer()
                saveButton
            }
        }
        .padding(.horizontal, DesignSystem.Spacing.generalHPadding)
            .background(Color.adaBackground)
            .onTapGesture {
                isEditing = false
            }
            .background(Color.adaBackground)
            .navigationTitle("Perfil")
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
            .sheet(isPresented: $openCameraRoll) {
                ImagePicker(selectedImage: $viewModel.imageSelected,
                            sourceType: .photoLibrary)
            }
    }
    
    @ViewBuilder
    private var imagePicker: some View {
        Button {
            openCameraRoll = true
        } label: {
            ProfilePictureView(imageSelected: $viewModel.imageSelected, imageUrl: $viewModel.imageUrl, size: 90)
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
                            .onTapGesture {
                                viewModel.onTagSelected(tagId: tag.id)
                            }
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
            .textContentType(.username)
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
            viewModel
                .save()
                .sink { _ in
                    
                } receiveValue: { _ in
                    presentationMode.wrappedValue.dismiss()
                }
                .store(in: &viewModel.cancelBag)

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
