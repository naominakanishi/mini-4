////
////  CustomModifiers.swift
////  AcademyUI
////
////  Created by HANNA P C FERREIRA on 18/05/22.
////
//
//import Foundation
//import SwiftUI
//import LocalAuthentication
//
//public struct MainTitle: View {
//    var title: String
//    public var body: some View {
//        Text(title)
//            .font(.system(size: 18))
//            .bold()
//            .foregroundColor(Color.white)
//            .padding(.leading, 16)
//    }
//}
//
//
//public struct TextFieldWithErrorModifier: ViewModifier {
//    
//    let fieldHeight: CGFloat = 51
//    var fieldBackgroundColor: Color = .adaBackground
//    var cornerRadius: CGFloat = 10
//    var error: String?
//
//    public func body(content: Content) -> some View {
//        VStack(alignment: .leading) {
//            HStack(alignment: .bottom, spacing: 8) {
//                VStack(alignment: .leading, spacing: 0) {
//                    content
//                    .padding(.horizontal, 30)
//                    .padding(.vertical, 16)
//                    .frame(maxWidth: .infinity, maxHeight: fieldHeight)
//                    .background(fieldBackgroundColor)
//                    .cornerRadius(cornerRadius)
//                    .corneredBorder(10, corners: .allCorners, color: error == nil ? .clear : .red, lineWidth: 2)
//                }
//            }
//            
//            if error != nil {
//                Text(error ?? "")
//                    .font(.system(size: 12))
//                    .foregroundColor(.red)
//            }
//        }
//    }
//}
//
//public struct ToastModifier: ViewModifier {
//    
//    var message: String
//    @Binding var isShowing: Bool
//    var duration: TimeInterval
//    var color: Color
//    
//    public func body(content: Content) -> some View {
//        ZStack {
//            content
//            if isShowing {
//                toast
//                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
//                    .animation(.easeInOut)
//                    .onAppear {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
//                            withAnimation {
//                                isShowing = false
//                            }
//                        }
//                    }
//            }
//        }
//    }
//    
//    private var toast: some View {
//        VStack {
//            VStack {
//                Text(message)
//                    .font(.system(size: 14))
//                    .fontWeight(.medium)
//                    .foregroundColor(.white)
//                    .padding(.horizontal, 30)
//                    .padding(.vertical, 20)
//            }
//            .background(color)
//            .cornerRadius(20)
//            .shadow(radius: 10)
//            
//            Spacer()
//        }
//        .padding(.top, 54)
//    }
//}
//
//public struct CarouselModifier: ViewModifier {
//    var hasTitle: Bool
//    var title: String = ""
//    
//    public func body(content: Content) -> some View {
//        if hasTitle {
//            MainTitle(title: title)
//        }
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 0) {
//                content
//            }
//        }
//    }
//}
//
//public struct TextFieldModifier: ViewModifier {
//    
//    @State var firstResponder: Int = 0
//    let titleSize: CGFloat = 14
//    var fontWeight: Font.Weight = .bold
//    var titleColor: Color = .white
//    let fieldHeight: CGFloat = 49
//    var fieldBackgroundColor: Color = .adaBackground
//    var cornerRadius: CGFloat = 12
//    var error: String?
//    var bottomPadding: CGFloat? = 4
//    var internalPadding: CGFloat = 15
//    
//    public init(){
//        
//    }
//    
//    public func body(content: Content) -> some View {
//        
//        VStack(alignment: .center, spacing: 0){
//            content
//            .padding(internalPadding)
//            .frame(maxWidth: UIScreen.main.bounds.width-30, maxHeight: fieldHeight)
//            .background(Color.white.opacity(0.1).adaGradient(repeatCount: 3))
//            .cornerRadius(cornerRadius)
//            .corneredBorder(cornerRadius, corners: .allCorners, color: error == nil ? .white : .red, lineWidth: 0.5)
//        }
//    }
//}
//
//struct CustomTextFieldModifier_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack{
//            CustomTextField(text: .constant("@hannapcf"),
//                            firstResponder: .constant(1),
//                            order: 1)
//            .modifier(TextFieldModifier())
//        }
//        .frame(height: 200)
//        .frame(maxWidth: .infinity)
//        .background(Color.adaBackground)
//    }
//}
