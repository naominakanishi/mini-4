//
//  ProfilePictureViewModel.swift
//  AcademyiOS
//
//  Created by HANNA P C FERREIRA on 17/05/22.
//

import Foundation
import UIKit

class ProfilePictureViewModel: ObservableObject {
    
    @Published var changePic: Bool
    @Published var openCameraRoll: Bool
    @Published var imageSelected: UIImage
    
    init(changePic: Bool, openCameraRoll: Bool, imageSelected: UIImage) {
        self.changePic = changePic
        self.openCameraRoll = openCameraRoll
        self.imageSelected = imageSelected
    }
    
    func changeProfilePic(){
        changePic = true
        openCameraRoll = true
    }
}
