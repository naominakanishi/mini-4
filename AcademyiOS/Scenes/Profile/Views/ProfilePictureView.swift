//
//  ProfilePictureView.swift
//  AcademyiOS
//
//  Created by HANNA P C FERREIRA on 17/05/22.
//

import SwiftUI

struct ProfilePictureView: View {
    
    @ObservedObject var viewModel: ProfilePictureViewModel
    
    var body: some View {
            Button(action: {
                viewModel.changeProfilePic()
            }, label: {
                if viewModel.changePic {
                    ZStack(alignment: .bottomTrailing){
                        VStack{
                            Image(uiImage: viewModel.imageSelected)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Text("Editar")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .fontWeight(.regular)
                                .padding(.top, 15)
                        }
                        
                    }
                } else{
                    VStack(alignment: .center, spacing: 0){
                        ZStack{
                            Image(systemName: "person.fill")
                                .resizable()
                                .padding(30)
                                .frame(width: 120, height: 120)
                                .foregroundColor(Color.white)
                        }
                        .background(Color.adaBackground)
                        .cornerRadius(25)
                        Text("Editar")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .fontWeight(.regular)
                            .padding(.top, 15)
                    }
                }
            })
    }
}


struct ProfilePictureView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 10) {
            ProfilePictureView(
                viewModel: ProfilePictureViewModel(changePic: false,
                                                   openCameraRoll: false,
                                                   imageSelected: UIImage())
            )
        }
        
    }
}
