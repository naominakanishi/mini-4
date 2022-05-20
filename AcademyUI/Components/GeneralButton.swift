//
//  GeneralButton.swift
//  AcademyUI
//
//  Created by HANNA P C FERREIRA on 19/05/22.
//

import SwiftUI

public struct GeneralButton: View {
    
    let title: String
    var image: String?
    var enabled: Bool = true
    var borderColor: Color?
    var hasOptions: Bool = false
    var hasChevron: Bool = false
    var hasSavedData: Bool = false
    var savedData: String?
    
    let onTap: () -> Void
    
    public init(title: String, image: String, enabled: Bool, borderColor: Color, hasOptions: Bool, hasChevron: Bool, hasSavedData: Bool, savedData: String, onTap: @escaping () -> Void){
        self.title = title
        self.image = image
        self.enabled = true
        self.borderColor = .clear
        self.hasOptions = hasOptions
        self.hasChevron = hasChevron
        self.hasSavedData = hasSavedData
        self.savedData = savedData
        self.onTap = onTap
    }
    
    public var body: some View {
        Button(action: onTap, label: {
            HStack{
                Image(systemName: image ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.adaLightBlue)
                    .frame(width: 34, height: 20)
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Spacer()
                if hasSavedData{
                    Text(savedData ?? "")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .fontWeight(.regular)
                        .padding(.trailing, 15)
                }
                if hasOptions {
                    Image(systemName: "arrowtriangle.down.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color.adaLightGrey)
                }
                if hasChevron {
                    Image(systemName: "chevron.forward")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color.adaLightGrey)
                }

                
            }
            .padding(.trailing)
            
        })
        .disabled(!enabled)
        .frame(maxWidth: .infinity)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.1).adaGradient(repeatCount: 3))
        .cornerRadius(12)
        
    }
}

struct GeneralButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            GeneralButton(title: "Aniversário",
                          image: "calendar",
                          enabled: true,
                          borderColor: .clear,
                          hasOptions: true,
                          hasChevron: false,
                          hasSavedData: true,
                          savedData: "01/01/2000",
                          onTap: {})
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.adaBackground)
        
    }
}
