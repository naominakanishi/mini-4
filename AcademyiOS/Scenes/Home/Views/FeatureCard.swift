import SwiftUI

struct FeatureCard: View {
    var title: String
    var maxHeight: CGFloat
    var color: Color
    var imageName: String
    var onTap: () -> ()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(color.homeCardGradient)
                .opacity(0.6)
            
            VStack(alignment: .leading) {
               Spacer()
                VStack {
                    HStack {
                        Spacer()
                        Image(imageName)
                            .padding(.trailing, 15)
                            .padding(.top, 15)
                    }
                    HStack {
                        Text(title)
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 32)
                        Spacer()
                    }
                    .padding()
                }
                
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color, lineWidth: 1)
        )
        .padding(4)
        .frame(maxHeight: maxHeight)
    }
}
