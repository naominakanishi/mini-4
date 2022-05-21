//
//  ProfilePictureView.swift
//  AcademyiOS
//
//  Created by HANNA P C FERREIRA on 17/05/22.
//

import SwiftUI

struct ProfilePictureView: View {
    
    @Binding
    var imageSelected: UIImage?
    
    var body: some View {
        if let image = imageSelected {
            userImage(image)
        } else{
            placeholderImage
        }
    }
    
    @ViewBuilder
    private func userImage(_ image: UIImage) -> some View {
        ZStack{
            Image(uiImage: imageSelected ?? .init())
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
    }
    
    
    @ViewBuilder
    private var placeholderImage: some View {
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
}
