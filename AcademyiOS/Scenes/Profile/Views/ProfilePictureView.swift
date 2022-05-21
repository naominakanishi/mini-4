//
//  ProfilePictureView.swift
//  AcademyiOS
//
//  Created by HANNA P C FERREIRA on 17/05/22.
//

import SwiftUI

//struct ProfilePictureView: View {
//
//    @ObservedObject var viewModel: ProfilePictureViewModel
//
//    var body: some View {
//            Button(action: {
//                viewModel.changeProfilePic()
//            }, label: {
//                if viewModel.changePic {
//                    ZStack(alignment: .bottomTrailing){
//                        VStack{
//                            Image(uiImage: viewModel.imageSelected)
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 120, height: 120)
//                                .clipShape(RoundedRectangle(cornerRadius: 10))
//                            Text("Editar")
//                                .font(.system(size: 14))
//                                .foregroundColor(.white)
//                                .fontWeight(.regular)
//                                .padding(.top, 15)
//                        }
//
//                    }
//                } else{
//                    VStack(alignment: .center, spacing: 0){
//                        ZStack{
//                            Image(systemName: "person.fill")
//                                .resizable()
//                                .padding(30)
//                                .frame(width: 120, height: 120)
//                                .foregroundColor(Color.white)
//                        }
//                        .background(Color.adaBackground)
//                        .cornerRadius(25)
//                        Text("Editar")
//                            .font(.system(size: 14))
//                            .foregroundColor(.white)
//                            .fontWeight(.regular)
//                            .padding(.top, 15)
//                    }
//                }
//            })
//    }
//}

struct ProfilePictureView: View {
    
    @ObservedObject var viewModel: ProfilePictureViewModel
    
    var body: some View {
            Button(action: {
                viewModel.changeProfilePic()
            }, label: {
                if viewModel.changePic {
                    ZStack{
                        Image(uiImage: viewModel.imageSelected)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 90, height: 90)
                            .overlay(
                                Circle()
                                .stroke(style: .init(
                                    lineWidth: 10,
                                    lineCap: .round,
                                    lineJoin: .round
                                ))
                                    .fill(.linearGradient(.init(
                                        colors: [
                                            Color.adaLightBlue,
                                            Color.adaLightBlue,
                                            (Color.adaLightBlue.opacity(0))]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing))
                                )
                    }
                    .background(
                        .linearGradient(.init(
                            colors: [(Color.adaLightBlue.opacity(0)),
                                     (Color.adaLightBlue.opacity(0.2)),
                                     (Color.adaLightBlue.opacity(0.4))]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing))
                    .clipShape(Circle())
                } else{
                    ZStack(alignment: .bottomTrailing){
                        ZStack{
                            Image(systemName: "person.fill")
                                .resizable()
                                .padding(30)
                                .frame(width: 90, height: 90)
                                .foregroundColor(Color(.white))
                                .overlay(
                                    Circle()
                                    .stroke(style: .init(
                                        lineWidth: 10,
                                        lineCap: .round,
                                        lineJoin: .round
                                    ))
                                        .fill(.linearGradient(.init(
                                            colors: [
                                                Color.adaLightBlue,
                                                Color.adaLightBlue,
                                                (Color.adaLightBlue.opacity(0))]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing))
                                    )
                        }
                        .background(
                            .linearGradient(.init(
                                colors: [(Color.adaLightBlue.opacity(0)),
                                         (Color.adaLightBlue.opacity(0.2)),
                                         (Color.adaLightBlue.opacity(0.4))]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing))
                        .clipShape(Circle())
                        ZStack(alignment: .center){
                            Image(systemName: "person.crop.square")
                                .resizable()
                                .padding(8)
                                .frame(width: 35, height: 35)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                        .background(Color.adaLightBlue)
                        .clipShape(Circle())
                    }
                }
            })
    }
}


struct ProfilePictureView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 10) {
            VStack{
                ProfilePictureView(viewModel: ProfilePictureViewModel(changePic: false,
                                                                   openCameraRoll: false,
                                                                   imageSelected: UIImage())
                )
            }
            
            
//            ProfilePictureView(
//                viewModel: ProfilePictureViewModel(changePic: false,
//                                                   openCameraRoll: false,
//                                                   imageSelected: UIImage())
//            )
        }
        .frame(width: 2000, height: 2000, alignment: .center)
        .background(Color.adaBackground)
        
        
    }
}
